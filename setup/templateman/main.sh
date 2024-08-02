#!/bin/bash

set -euo pipefail

function locateCmd() {
    which $1 >/dev/null || {
        echo "::error::Could not find $1"
        exit 1
    }
}

locateCmd "go"

echo "::debug::Using $(go version)"

echo "::debug::Installing TemplateMan CLI ${VERSION}"
install=$(go install -v "github.com/projectdiscovery/templateman/templateman-cli/cmd/tmc@${VERSION}")

locateCmd "tmc"
