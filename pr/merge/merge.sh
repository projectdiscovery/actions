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

gh pr merge "${PR_NUMBER}" \
    --repo "${INPUT_REPOSITORY}" \
    --${INPUT_MERGE_METHOD} \
    ${AUTO_FLAG} \
    ${DELETE_FLAG} \
    && {
      echo "merged=true"
      echo "pr-number=${PR_NUMBER}"
    } >> "${GITHUB_OUTPUT}" \
    || {
      printErrorWithExit "Failed to merge PR #${PR_NUMBER}." 1
    }

