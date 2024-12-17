#!/bin/bash

set -euo pipefail

printDebug "Prepend user's ID to user's email"
if [[ "${USERNAME}" == "${GITHUB_ACTOR}" ]]; then
	EMAIL="${GITHUB_ACTOR_ID}+${EMAIL}"
fi

printDebug "Lowercasing user's email"
EMAIL=${EMAIL,,}

printDebug "Set git user's email"
git config --$SCOPE user.email "${EMAIL}"

printDebug "Set git user's name"
git config --$SCOPE user.name "${USERNAME}"

echo "email=${EMAIL}" >> $GITHUB_OUTPUT