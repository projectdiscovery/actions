#!/bin/bash

echo "::debug::Remove any trailing newlines from input files"
FILES="$(echo -n "${FILES}")"

echo "::debug::$(wc -l <<< "${FILES}") files to commit"

while IFS= read -r file; do
    add=$(git add "${file}" 2>&1)
    [[ $? -gt 0 ]] && echo "::warning::${add}"
done <<< "${FILES}"

commit=$(git commit -m "${MESSAGE}" 2>&1)
[[ $? -gt 0 ]] && echo "::warning::Could not create commit: $(tail -n 1 <<< "${commit}")"