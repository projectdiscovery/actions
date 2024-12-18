#!/bin/bash

set -euo pipefail

source "$(git rev-parse --show-toplevel)/.bash_aliases"

cmdMustExists "go"

printDebug "Using $(go version)"
printDebug "Installing Generate Index CLI ${VERSION}"
install=$(go install -v "github.com/projectdiscovery/nucleish-api/cmd/generate-index@${VERSION}")

cmdMustExists "generate-index"
