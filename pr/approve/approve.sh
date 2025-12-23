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

gh pr review "${PR_NUMBER}" \
    --repo "${INPUT_REPOSITORY}" \
    --approve \
    --body "${INPUT_APPROVE_MESSAGE}" \
    && {
      echo "approved=true"
      echo "pr-number=${PR_NUMBER}"
    } >> "${GITHUB_OUTPUT}" \
    || {
      printErrorWithExit "Failed to approve PR #${PR_NUMBER}." 1
    }
