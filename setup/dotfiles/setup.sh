#!/bin/bash

TEMP_FILE=$(mktemp)

curl -fsSL "${INPUT_FILE}" > "${TEMP_FILE}"
[[ $? -ne 0 ]] && {
    echo "::error::Failed to download dotfile from \"${INPUT_FILE}\""
    exit 1
}

source "${TEMP_FILE}"
rm -rf "${TEMP_FILE}"

# export all functions to be used in other scripts
declare -f >> ~/.bash_aliases