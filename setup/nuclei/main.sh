#!/bin/bash
###
# Deprecated: This action is deprecated and will be removed in the future.
###

set -euo pipefail

source "$(git rev-parse --show-toplevel)/.bash_aliases"

cmdMustExists "go"

printDebug "Using $(go version)"
printDebug "Installing Nuclei ${VERSION}"
install=$(go install -v "github.com/projectdiscovery/nuclei/v3/cmd/nuclei@${VERSION}")

cmdMustExists "nuclei"

printDebug "Getting Nuclei version"
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
