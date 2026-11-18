#!/bin/bash
#
# Commits the module's upgrades through the GitHub REST API and opens or
# updates a pull request with govulnbump's report. GitHub signs commits that
# the API creates with GITHUB_TOKEN or a GitHub App token, so no signing key or
# git identity is needed.
#
# Avoid bash 4 features: macOS runners have bash 3.2 at /bin/bash.

set -euo pipefail

tmp="${TEMP_DIR}"
report="${tmp}/report.txt"
index="${tmp}/index"
repo="${GITHUB_REPOSITORY}"

# When govulnbump upgraded modules, the report starts with them: a header line
# starting with "Fixed", then each module as "  path from => to", with its
# advisories indented further.
title="$(awk '
	NR == 1 { if ($1 != "Fixed") exit; next }
	/^$/ { exit }
	/^  [^ ]/ { n++; mod = $1; from = $2; to = $4 }
	END {
		if (n == 1) printf "fix(deps): bump %s from %s to %s", mod, from, to
		else if (n > 1) printf "fix(deps): bump %d vulnerable Go modules", n
	}' "${report}")"
if [[ -z "${title}" ]]; then
	echo "govulnbump upgraded nothing; not opening a pull request."
	exit 0
fi

# Split pr-args with xargs, which honors quotes without running anything:
# labels such as "Type: Maintenance" contain spaces. Do it before pushing, so
# that a quoting mistake doesn't leave a branch without a pull request.
xargs -r printf '%s\0' <<<"${PR_ARGS}" >"${tmp}/pr-args"
pr_args=()
while IFS= read -r -d '' arg; do
	pr_args+=("${arg}")
done <"${tmp}/pr-args"

# The step runs in working-directory, so go finds the module that govulnbump
# upgraded, unless -C in args sent govulnbump elsewhere. dir is the module's
# directory in the repository, with a trailing slash, or empty at the root.
gomod="$(go env GOMOD)"
[[ "${gomod}" == */go.mod ]] && cd "$(dirname "${gomod}")"
dir="$(git rev-parse --show-prefix)"
cd "$(git rev-parse --show-toplevel)"
gomod="${dir}go.mod"
if git diff --quiet HEAD -- "${gomod}"; then
	echo "::error::govulnbump upgraded modules, but ${gomod} didn't change. Set working-directory instead of passing -C in args."
	exit 1
fi

base="$(git symbolic-ref --short -q HEAD)" || {
	echo "::error::create-pr needs a checked-out branch to open the pull request against"
	exit 1
}
parent="$(git rev-parse HEAD)"

# One branch per base branch and module, so each keeps one pull request up to
# date. Slashes in the names would make branches collide, as git can't have
# both a/b and a/b/c.
module="$(go mod edit -json "${gomod}" | jq -r .Module.Path)"
branch="govulnbump/${base//\//-}/${module//\//-}"
git check-ref-format --branch "${branch}" >/dev/null

# Stage the module's files in a separate index, which leaves the caller's index
# alone and gives the tree the commit will have. git add fails on a path that
# doesn't exist or is ignored, so add go.sum and vendor only if they're tracked.
paths=("${gomod}")
git cat-file -e "HEAD:${dir}go.sum" 2>/dev/null && paths+=("${dir}go.sum")
git cat-file -e "HEAD:${dir}vendor" 2>/dev/null && paths+=("${dir}vendor")
rm -f "${index}"
GIT_INDEX_FILE="${index}" git read-tree HEAD
GIT_INDEX_FILE="${index}" git add -A -- "${paths[@]}"
tree="$(GIT_INDEX_FILE="${index}" git write-tree)"

# Pull requests for the branch, ignoring forks, which can use any branch name.
prs() {
	gh pr list --repo "${repo}" --head "${branch}" --base "${base}" --state "$1" \
		--json number,isCrossRepository --jq '[.[] | select(.isCrossRepository | not) | .number]'
}

# The branch is current when its one commit on this parent has this tree.
# Pushing it again would add a commit for nothing, and with an App token or a
# personal access token, restart the pull request's checks. A failed lookup
# counts as no branch: creating the branch then fails if it does exist.
current=false
if remote="$(gh api "repos/${repo}/git/ref/heads/${branch}" --jq .object.sha 2>/dev/null)"; then
	# Assign API results before testing them: set -e ignores a failed command
	# substitution inside [[ ]], and a failed compare would then force the
	# update below.
	compare="$(gh api "repos/${repo}/compare/${parent}...${remote}" \
		--jq '"\(.ahead_by) \(.behind_by) \(.commits[-1].commit.tree.sha)"')"
	if [[ "${compare}" == "1 0 ${tree}" ]]; then
		# A closed pull request for the same upgrades stays closed.
		count="$(prs all | jq length)"
		if [[ "${count}" -gt 0 ]]; then
			echo "${branch} already has these upgrades."
			exit 0
		fi
		current=true
	elif [[ "${compare%% *}" -gt 1 ]]; then
		# Rebuilding the branch drops commits that someone else pushed to
		# it, for example to adapt code to an upgrade.
		echo "::warning::${branch} has commits besides govulnbump's; not updating it."
		exit 0
	fi
else
	remote=
fi

if [[ "${current}" == false ]]; then
	# Send UTF-8 files inline, so that GitHub writes their blobs without a
	# request for each file: the API accepts only 80 such requests a minute.
	# Upload other files as base64 blobs. File contents go through stdin, as
	# Linux limits a single argument to 128 KiB.
	entries="${tmp}/entries.jsonl"
	: >"${entries}"
	GIT_INDEX_FILE="${index}" git diff-index --cached --no-renames -z HEAD >"${tmp}/diff"
	while IFS= read -r -d '' meta && IFS= read -r -d '' path; do
		read -r old_mode new_mode _ sha status <<<"${meta#:}"
		if [[ "${status}" == D ]]; then
			jq -nc --arg path "${path}" --arg mode "${old_mode}" \
				'{path: $path, mode: $mode, type: "blob", sha: null}'
		else
			git cat-file blob "${sha}" >"${tmp}/blob"
			if iconv -f UTF-8 -t UTF-8 <"${tmp}/blob" >/dev/null 2>&1; then
				jq -Rsc --arg path "${path}" --arg mode "${new_mode}" \
					'{path: $path, mode: $mode, type: "blob", content: .}' <"${tmp}/blob"
			else
				blob="$(base64 <"${tmp}/blob" | tr -d '\n' |
					jq -Rsc '{content: ., encoding: "base64"}' |
					gh api -X POST "repos/${repo}/git/blobs" --input - --jq .sha)"
				jq -nc --arg path "${path}" --arg mode "${new_mode}" --arg sha "${blob}" \
					'{path: $path, mode: $mode, type: "blob", sha: $sha}'
			fi
		fi >>"${entries}"
	done <"${tmp}/diff"

	tree="$(jq -sc --arg base "$(git rev-parse 'HEAD^{tree}')" '{base_tree: $base, tree: .}' "${entries}" |
		gh api -X POST "repos/${repo}/git/trees" --input - --jq .sha)"

	# Leave author and committer unset: GitHub signs only commits without them.
	commit="$(jq -nc --arg title "${title}" --rawfile report "${report}" --arg tree "${tree}" --arg parent "${parent}" \
		'{message: ($title + "\n\n" + $report), tree: $tree, parents: [$parent]}' |
		gh api -X POST "repos/${repo}/git/commits" --input - --jq .sha)"

	if [[ -n "${remote}" ]]; then
		gh api -X PATCH "repos/${repo}/git/refs/heads/${branch}" -f sha="${commit}" -F force=true --silent
	else
		gh api -X POST "repos/${repo}/git/refs" -f ref="refs/heads/${branch}" -f sha="${commit}" --silent
	fi
fi

body="${tmp}/body.md"
printf '```\n%s\n```\n' "$(cat "${report}")" >"${body}"
number="$(prs open | jq -r '.[0] // empty')"
if [[ -n "${number}" ]]; then
	# gh pr edit fails on older gh releases that query Projects (classic).
	gh api -X PATCH "repos/${repo}/pulls/${number}" -f title="${title}" -F body=@"${body}" --jq .html_url
else
	# pr-args apply only to a new pull request, so that later runs don't undo
	# what maintainers changed. The flags after them win over any that
	# pr-args repeats.
	gh pr create ${pr_args[@]+"${pr_args[@]}"} \
		--repo "${repo}" --head "${branch}" --base "${base}" --title "${title}" --body-file "${body}"
fi
