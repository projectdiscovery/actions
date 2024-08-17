#!/bin/bash

set -euo pipefail

TARGET=$(eval realpath "${TARGET}")
NUCLEI_TEMPLATES="projectdiscovery/nuclei-templates"
NUCLEI_TEMPLATES_URL="https://github.com/${NUCLEI_TEMPLATES}"

if [[ "${VERSION}" == "latest" ]]; then
    downloadURL="${NUCLEI_TEMPLATES_URL}/archive/refs/heads/main.zip"
elif [[ "${VERSION}" == "stable" ]]; then
    latestTag=$(curl -s "https://api.github.com/repos/${NUCLEI_TEMPLATES}/tags" | jq -r '.[0].name')
    VERSION="${latestTag}"
    downloadURL="${NUCLEI_TEMPLATES_URL}/archive/refs/tags/${latestTag}.zip"
else
    downloadURL="${NUCLEI_TEMPLATES_URL}/archive/refs/tags/${VERSION}.zip"
fi

echo "::debug::Changing working directory to /tmp"
cd /tmp

echo "::debug::Downloading Nuclei templates (${VERSION})"
wget "${downloadURL}" -qO nuclei-templates.zip

echo "::debug::Extracting Nuclei templates"
unzip -q nuclei-templates.zip -d ./nuclei-templates

echo "::debug::Creating "${TARGET}" directory"
mkdir -p "${TARGET}"

echo "::debug::Copying to "${TARGET}" directory"
cp -r ./nuclei-templates/*/* "${TARGET}"

echo "::debug::Revert working directory"
cd -
