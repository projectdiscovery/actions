#!/bin/bash

set -euo pipefail

valid_scopes=("global" "system" "local" "worktree")

echo "::debug::Validate input scope"
if [[ ! "${valid_scopes[@]}" =~ "${SCOPE}" ]]; then
	echo "::error::Invalid scope specified: \"${SCOPE}\""
	echo "::error::Valid scopes are \"global\", \"system\", \"local\", or \"worktree\"."
	exit 1
fi