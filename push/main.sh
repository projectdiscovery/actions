#!/bin/bash
#
# Pushes HEAD to the branch REF on origin. Runs under the env: block of
# action.yaml, which supplies REF, TOKEN, REBASE, DRY_RUN and SERVER_URL.

set -euo pipefail

# REF is a branch name or its full refname, refs/heads/<name>. action.yaml
# leaves it empty when the run is not on a branch.
name="${REF#refs/heads/}"
if [[ -z "${name}" ]]; then
    echo "::error::Set ref: this run is not on a branch"
    exit 1
fi
if [[ "${name}" == refs/* ]]; then
    echo "::error::ref must be a branch name or refs/heads/<name>"
    exit 1
fi
# Push to a full refname so that git doesn't have to guess whether a name that
# is not on the remote is a branch or a tag.
dest="refs/heads/${name}"

if [[ -n "${TOKEN}" ]]; then
    # Keep the token out of .git/config and the process arguments by passing
    # it as config in the environment, which only this script's git processes
    # see. The header has the shape actions/checkout persists, under the same
    # key, so the empty value first resets a persisted header. Otherwise git
    # would send both, and GitHub answers a request with two Authorization
    # headers with a 400 (actions/checkout#2215). The runner masks the base64
    # forms of a secret, which covers this header.
    b64="$(printf 'x-access-token:%s' "${TOKEN}" | base64 | tr -d '\n')"

    # Append after any config entries the job already passes this way.
    n="${GIT_CONFIG_COUNT:-0}"
    export "GIT_CONFIG_KEY_${n}=http.${SERVER_URL}/.extraheader"
    export "GIT_CONFIG_VALUE_${n}="
    export "GIT_CONFIG_KEY_$((n + 1))=http.${SERVER_URL}/.extraheader"
    export "GIT_CONFIG_VALUE_$((n + 1))=AUTHORIZATION: basic ${b64}"
    export GIT_CONFIG_COUNT="$((n + 2))"
fi

if [[ "${REBASE}" == 'true' ]]; then
    # git pull fails when the remote has no such branch, which is a normal
    # state for a branch that is about to be created. Ask in a separate
    # assignment so a failure of ls-remote itself, such as bad credentials,
    # stops the script instead of reading as "no such branch".
    remote_branch="$(git ls-remote --heads origin "${dest}")"

    if [[ -n "${remote_branch}" ]]; then
        git pull --rebase origin "${dest}"
    else
        echo "::notice::${dest} is not on origin yet, so there is nothing to rebase onto"
    fi
fi

args=(origin "HEAD:${dest}")
if [[ "${DRY_RUN}" == 'true' ]]; then
    args=(--dry-run "${args[@]}")
fi

git push "${args[@]}"
