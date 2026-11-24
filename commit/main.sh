#!/bin/bash

source <(curl -fsSL "https://github.com/projectdiscovery/actions/raw/refs/heads/dotfiles/.bash_aliases")

printDebug "Remove any trailing newlines from input files"
FILES="$(echo -n "${FILES}")"

printDebug "$(wc -l <<< "${FILES}") files to commit"

while IFS= read -r file; do
    add=$(git add "${file}" 2>&1)
    [[ $? -gt 0 ]] && printWarning "${add}"
    printDebug "${add}"
done <<< "${FILES}"

# `git commit` exits 1 both when nothing is staged and when a hook rejects
# the commit, so check the index first. Nothing staged is not a failure.
if git diff --cached --quiet 2>/dev/null; then
    printWarning "Nothing to commit"
    exit 0
fi

if ! commit=$(git commit -m "${MESSAGE}" 2>&1); then
    # A workflow command ends at a line break, so escape git's output the way
    # @actions/core does to keep all of it, such as a hook's message or a
    # signing error, in one annotation.
    msg=${commit//%/%25}
    msg=${msg//$'\r'/%0D}
    msg=${msg//$'\n'/%0A}
    printErrorWithExit "Could not create commit: ${msg}" "1"
fi
printDebug "${commit}"