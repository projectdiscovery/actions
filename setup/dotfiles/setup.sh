#!/bin/bash

TEMP_FILE=$(mktemp)

curl -fsSL "${INPUT_FILE}" > "${TEMP_FILE}"
[[ $? -ne 0 ]] && {
    echo "::error::Failed to download dotfile from \"${INPUT_FILE}\""
    exit 1
}

echo "source ${TEMP_FILE}" >> ~/.bashrc