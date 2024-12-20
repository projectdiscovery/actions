#!/bin/bash

set -euo pipefail

source "$(sed "s|\(.*projectdiscovery/actions/[^/]*\).*|\1|" <<< "$GITHUB_ACTION_PATH")/.bash_aliases"

cmdMustExists "go"

printDebug "Using $(go version)"
printDebug "Installing Generate Index CLI ${VERSION}"
install=$(go install -v "github.com/projectdiscovery/nucleish-api/cmd/generate-index@${VERSION}")

cmdMustExists "generate-index"
