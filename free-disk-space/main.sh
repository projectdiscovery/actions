#!/usr/bin/env bash
set -euo pipefail

source <(curl -fsSL "https://github.com/projectdiscovery/actions/raw/refs/heads/dotfiles/.bash_aliases")

if [[ "$RUNNER_OS" != "Linux" ]]; then
    printErrorWithExit "This action is only supported on Linux runners. Skipping..." 0
fi

if [[ "${INPUT_ANDROID}" == "true" ]]; then
    sudo rm -rf /usr/local/lib/android
fi

if [[ "${INPUT_DOTNET}" == "true" ]]; then
    sudo rm -rf /usr/share/dotnet
    sudo apt-get remove -y '^dotnet-.*'
    sudo apt-get autoremove -y
    sudo apt-get clean
fi

if [[ "${INPUT_HASKELL}" == "true" ]]; then
    sudo rm -rf /opt/ghc
fi

if [[ "${INPUT_LLVM}" == "true" ]]; then
    sudo apt-get remove -y '^llvm-.*'
    sudo apt-get autoremove -y
    sudo apt-get clean
fi

if [[ "${INPUT_PHP}" == "true" ]]; then
    sudo apt-get remove -y '^php[0-9.\\-]*'
    sudo apt-get autoremove -y
    sudo apt-get clean
fi

if [[ "${INPUT_MONGODB}" == "true" ]]; then
    sudo apt-get remove -y '^mongodb-.*'
    sudo apt-get autoremove -y
    sudo apt-get clean
fi

if [[ "${INPUT_MYSQL}" == "true" ]]; then
    sudo apt-get remove -y '^mysql-.*'
    sudo apt-get autoremove -y
    sudo apt-get clean
fi

if [[ "${INPUT_MISC_PACKAGES}" == "true" ]]; then
    sudo apt-get remove -y \
        azure-cli google-cloud-sdk \
        google-chrome-stable firefox \
        powershell mono-devel libgl1-mesa-dri
    sudo apt-get autoremove -y
    sudo apt-get clean
fi

if [[ "${INPUT_DOCKER_IMAGES}" == "true" ]]; then
    sudo docker image prune -af
fi

if [[ "${INPUT_TOOLS_CACHE}" == "true" ]]; then
    sudo rm -rf "${AGENT_TOOLSDIRECTORY}"
fi

if [[ "${INPUT_SWAP_STORAGE}" == "true" ]]; then
    sudo swapoff -a
    sudo rm -f /mnt/swapfile
fi