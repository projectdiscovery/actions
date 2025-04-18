#!/bin/bash

set -euo pipefail

source <(curl -fsSL "https://github.com/projectdiscovery/actions/raw/refs/heads/dotfiles/.bash_aliases")

cmdMustExists "curl"
cmdMustExists "jq"

INPUT_NAME=$(toURLEncoded "${INPUT_NAME}")
INPUT_PROF=$(eval realpath "${INPUT_PROF}")
BASE_INPUT_PROF=$(basename "${INPUT_PROF}")
BASE_INPUT_PROF=$(toURLEncoded "${BASE_INPUT_PROF}")

curl_cmd="curl -s --data-binary \"@${INPUT_PROF}\" \"https://flamegraph.com/?name=${INPUT_NAME}&file_name=${BASE_INPUT_PROF}\""
printDebug "${curl_cmd}"

upload="$(eval "${curl_cmd}")"
printDebug "${upload}"

flamegraph_key=$(jq -r '.key | walk(if . == null then "" else . end)' <<< "${upload}")
flamegraph_url=$(jq -r '.url | walk(if . == null then "" else . end)' <<< "${upload}")
flamegraph_message=$(jq -r '.message | walk(if . == null then "" else . end)' <<< "${upload}")

{
    echo "key=${flamegraph_key}"
    echo "url=${flamegraph_url}"
    echo "message=${flamegraph_message}"
} >> $GITHUB_OUTPUT

if [[ -n "${flamegraph_message}" ]]; then
    printError "${flamegraph_message}"
    exit 1
fi