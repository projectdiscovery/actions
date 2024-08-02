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

echo "::debug::Installing Nuclei ${VERSION}"
install=$(go install -v "github.com/projectdiscovery/nuclei/v3/cmd/nuclei@${VERSION}")

locateCmd "nuclei"

echo "::debug::Getting Nuclei version"
get_version=$(nuclei --version 2>&1)

version=$(echo "${get_version}" | awk '/Nuclei Engine Version:/ {print $NF}')
config_dir=$(echo "${get_version}" | awk '/Nuclei Config Directory:/ {print $NF}')
cache_dir=$(echo "${get_version}" | awk '/Nuclei Cache Directory:/ {print $NF}')
pdcp_dir=$(echo "${get_version}" | awk '/PDCP Directory:/ {print $NF}')

{
  echo "version=${version}"
  echo "config_dir=${config_dir}"
  echo "cache_dir=${cache_dir}"
  echo "pdcp_dir=${pdcp_dir}"
} >> $GITHUB_OUTPUT
