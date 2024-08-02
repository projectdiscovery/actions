#!/bin/bash

set -euo pipefail

echo "::debug::Remove any trailing newlines from input files"
FILES="$(echo -n "${FILES}")"

echo "::debug::$(wc -l <<< "${FILES}") files to commit"

while IFS= read -r file; do
    git add "${file}"
done <<< "${FILES}"

git commit -m "${MESSAGE}"