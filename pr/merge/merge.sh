#!/bin/bash

set -euo pipefail

source <(curl -fsSL "https://github.com/projectdiscovery/actions/raw/refs/heads/dotfiles/.bash_aliases")

PR_NUMBER="${INPUT_PR_NUMBER}"
if [[ -z "${PR_NUMBER}" ]]; then
    PR_NUMBER="${OUTPUT_PR_NUMBER}"
fi

if [[ -z "${PR_NUMBER}" ]]; then
    printErrorWithExit "PR number could not be determined." 1
fi

# delete branch flag
DELETE_FLAG=""
if [[ "${INPUT_DELETE_BRANCH:-}" == "true" ]]; then
    DELETE_FLAG="--delete-branch"
fi

# auto-merge flag
AUTO_FLAG=""
if [[ "${INPUT_AUTO:-}" == "true" ]]; then
    AUTO_FLAG="--auto"
fi

MAX_ATTEMPTS="${INPUT_MAX_RETRIES:-3}"
DELAY="${INPUT_RETRY_DELAY:-5}"

# Patterns that indicate a transient failure worth retrying. Anything
# else (merge conflict, branch protection, missing review, etc.) is a
# real failure and we fail fast instead of burning retries.
TRANSIENT_PATTERNS=(
    "Base branch was modified"
    "HTTP 5"
    "rate limit"
    "secondary rate limit"
    "i/o timeout"
    "connection reset"
    "connection refused"
    "could not resolve host"
    "TLS handshake timeout"
    "EOF"
)

is_transient() {
    local err="$1" pat rc=1
    shopt -s nocasematch
    for pat in "${TRANSIENT_PATTERNS[@]}"; do
        if [[ "${err}" == *"${pat}"* ]]; then
            rc=0
            break
        fi
    done
    shopt -u nocasematch
    return "${rc}"
}

attempt=1
while :; do
    if STDERR_OUTPUT=$(gh pr merge "${PR_NUMBER}" \
        --repo "${INPUT_REPOSITORY}" \
        --${INPUT_MERGE_METHOD} \
        ${AUTO_FLAG} \
        ${DELETE_FLAG} \
        2>&1); then
        {
            echo "merged=true"
            echo "pr-number=${PR_NUMBER}"
        } >> "${GITHUB_OUTPUT}"
        echo "Successfully merged PR #${PR_NUMBER} (attempt ${attempt}/${MAX_ATTEMPTS})."
        exit 0
    fi

    if is_transient "${STDERR_OUTPUT}" && (( attempt < MAX_ATTEMPTS )); then
        echo "::warning::PR #${PR_NUMBER}: transient merge failure (attempt ${attempt}/${MAX_ATTEMPTS}). Retrying in ${DELAY}s..."
        echo "${STDERR_OUTPUT}" >&2
        sleep "${DELAY}"
        DELAY=$(( DELAY * 2 ))
        attempt=$(( attempt + 1 ))
        continue
    fi

    echo "${STDERR_OUTPUT}" >&2
    printErrorWithExit "Failed to merge PR #${PR_NUMBER} after ${attempt} attempt(s)." 1
done
