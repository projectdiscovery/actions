#!/bin/bash

set -euo pipefail

source <(curl -fsSL "https://github.com/projectdiscovery/actions/raw/refs/heads/dotfiles/.bash_aliases")

cmdMustExists "go"

printDebug "Using $(go version)"
printDebug "Installing Generate Index CLI ${VERSION}"
install=$(go install -v "github.com/projectdiscovery/nucleish-api/cmd/generate-index@${VERSION}")

cmdMustExists "generate-index"
