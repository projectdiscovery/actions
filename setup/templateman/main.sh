#!/bin/bash

set -euo pipefail

source "$(sed "s|\(.*projectdiscovery/actions/[^/]*\).*|\1|" <<< "$GITHUB_ACTION_PATH")/.bash_aliases"

cmdMustExists "go"

printDebug "Using $(go version)"
printDebug "Installing TemplateMan CLI ${VERSION}"
install=$(go install -v "github.com/projectdiscovery/templateman/templateman-cli/cmd/tmc@${VERSION}")

cmdMustExists "tmc"
