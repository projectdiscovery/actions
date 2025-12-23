#!/bin/bash

set -euo pipefail

source <(curl -fsSL "https://github.com/projectdiscovery/actions/raw/refs/heads/dotfiles/.bash_aliases")

MERGE_METHOD="${INPUT_MERGE_METHOD}"
if [[ "${MERGE_METHOD}" != "merge" && "${MERGE_METHOD}" != "squash" && "${MERGE_METHOD}" != "rebase" ]]; then
    printErrorWithExit "Invalid merge-method. Must be one of: merge, squash, rebase." 1
fi