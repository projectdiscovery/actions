#!/bin/bash

source "$(git rev-parse --show-toplevel)/.bash_aliases"

printDebug "Remove any trailing newlines from input files"
FILES="$(echo -n "${FILES}")"

printDebug "$(wc -l <<< "${FILES}") files to commit"

while IFS= read -r file; do
    add=$(git add "${file}" 2>&1)
    [[ $? -gt 0 ]] && printWarning "${add}"
    printDebug "${add}"
done <<< "${FILES}"

commit=$(git commit -m "${MESSAGE}" 2>&1)
[[ $? -gt 0 ]] && printWarning "Could not create commit: $(tail -n 1 <<< "${commit}")"
printDebug "${commit}"