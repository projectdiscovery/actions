#!/bin/bash

source <(curl -fsSL "https://github.com/projectdiscovery/actions/raw/refs/heads/dotfiles/.bash_aliases")
source <(curl -fsSL "https://github.com/cloudflare/semver_bash/raw/refs/heads/master/semver.sh")

TAG="${INPUT_TAG}"

if [[ -z "$TAG" ]]; then
    TAG="$(git describe --tags --abbrev=0)"
fi

if [[ -z "$TAG" ]]; then
    printErrorWithExit "Could not find a tag in the current branch. Please set the input 'tag'." 1
fi

MAJOR=0
MINOR=0
PATCH=0
SPECIAL=""

semverParseInto $TAG MAJOR MINOR PATCH SPECIAL
printNotice "$TAG -> M: $MAJOR m:$MINOR p:$PATCH s:$SPECIAL"

{
    echo "major=${MAJOR}"
    echo "minor=${MINOR}"
    echo "patch=${PATCH}"
    echo "special=${SPECIAL}"
    echo "version=${MAJOR}.${MINOR}.${PATCH}"
} >> $GITHUB_OUTPUT