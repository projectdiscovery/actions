#!/usr/bin/env bash
set -euo pipefail

action_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
temp_root="$(cd "${TMPDIR:-/tmp}" && pwd -P)"
test_dir="$(mktemp -d "${temp_root}/commit-action-test.XXXXXX")"
cleanup() {
    # Only remove the temporary directory allocated by this test.
    case "$(cd "${test_dir}" && pwd -P)" in
        "${temp_root}"/commit-action-test.*) rm -rf -- "${test_dir}" ;;
    esac
}
trap cleanup EXIT

export GIT_CONFIG_NOSYSTEM=1
export GIT_CONFIG_GLOBAL=/dev/null
export GIT_TERMINAL_PROMPT=0

# Supply the action's logging helpers locally so tests need no network.
mkdir "${test_dir}/bin"
cat > "${test_dir}/bin/curl" <<'EOF'
#!/usr/bin/env bash
cat <<'HELPERS'
printDebug() { printf '%s\n' "$*"; }
printWarning() { printf '%s\n' "$*" >&2; }
HELPERS
EOF
chmod +x "${test_dir}/bin/curl"
export PATH="${test_dir}/bin:${PATH}"

setup_repository() {
    local name="$1"
    local case_dir="${test_dir}/${name}"
    mkdir "${case_dir}"
    git init --quiet --bare "${case_dir}/remote.git"
    git init --quiet -b main "${case_dir}/work"
    cd "${case_dir}/work"
    git config user.name 'Commit action test'
    git config user.email 'commit-test@example.invalid'
    printf 'initial\n' > 'test file.txt'
    git add 'test file.txt'
    git commit --quiet -m initial
    git remote add origin "${case_dir}/remote.git"
    git push --quiet --set-upstream origin main
    initial_commit="$(git rev-parse HEAD)"
}

remote_commit() {
    git --git-dir="../remote.git" rev-parse refs/heads/main
}

run_action() {
    FILES='test file.txt' MESSAGE='test commit' bash "${action_dir}/main.sh"
}

for mode in default false true; do
    setup_repository "${mode}"
    printf 'changed\n' >> 'test file.txt'
    if [[ "${mode}" == default ]]; then
        unset PUSH
    else
        export PUSH="${mode}"
    fi
    run_action
    [[ "$(git rev-parse HEAD)" != "${initial_commit}" ]]
    if [[ "${mode}" == true ]]; then
        [[ "$(remote_commit)" == "$(git rev-parse HEAD)" ]]
    else
        [[ "$(remote_commit)" == "${initial_commit}" ]]
    fi
    printf 'PASS: push=%s\n' "${mode}"
done

setup_repository no-changes
export PUSH=true
# Leave a local commit ahead of origin. With no new changes to commit, the
# action must not push existing history merely because push was requested.
git commit --quiet --allow-empty -m 'existing local commit'
run_action
[[ "$(remote_commit)" == "${initial_commit}" ]]
printf 'PASS: no new commit does not push\n'

setup_repository rejected-commit
git commit --quiet --allow-empty -m 'existing local commit'
printf '#!/bin/sh\nexit 1\n' > .git/hooks/pre-commit
chmod +x .git/hooks/pre-commit
printf 'changed\n' >> 'test file.txt'
run_action
[[ "$(remote_commit)" == "${initial_commit}" ]]
printf 'PASS: rejected commit does not push\n'

setup_repository rejected-push
printf '#!/bin/sh\nexit 1\n' > ../remote.git/hooks/pre-receive
chmod +x ../remote.git/hooks/pre-receive
printf 'changed\n' >> 'test file.txt'
if run_action; then
    printf 'FAIL: rejected push returned success\n' >&2
    exit 1
fi
[[ "$(git rev-parse HEAD)" != "${initial_commit}" ]]
[[ "$(remote_commit)" == "${initial_commit}" ]]
printf 'PASS: rejected push fails and keeps the local commit\n'
