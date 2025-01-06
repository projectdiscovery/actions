#!/bin/bash

set -euo pipefail

source <(curl -fsSL "https://github.com/projectdiscovery/actions/raw/refs/heads/dotfiles/.bash_aliases")

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

printDebug "Changing working directory to /tmp"
cd /tmp

printDebug "Downloading Nuclei templates (${VERSION})"
wget "${downloadURL}" -qO nuclei-templates.zip

printDebug "Extracting Nuclei templates"
unzip -q nuclei-templates.zip -d ./nuclei-templates

printDebug "Creating "${TARGET}" directory"
mkdir -p "${TARGET}"

printDebug "Copying to "${TARGET}" directory"
cp -r ./nuclei-templates/*/* "${TARGET}"

printDebug "Revert working directory"
cd -
