#!/bin/bash

set -euo pipefail

source "$(sed "s|\(.*projectdiscovery/actions/[^/]*\).*|\1|" <<< "$GITHUB_ACTION_PATH")/.bash_aliases"

valid_scopes=("global" "system" "local" "worktree")

printDebug "Validate input scope"
if [[ ! "${valid_scopes[@]}" =~ "${SCOPE}" ]]; then
	printError "Invalid scope specified: \"${SCOPE}\""
	printError "Valid scopes are \"global\", \"system\", \"local\", or \"worktree\"."
	exit 1
fi