#!/bin/bash

set -euo pipefail

function locateCmd() {
    which $1 >/dev/null || {
        echo "::error::Could not find $1"
        exit 1
    }
}

locateCmd "curl"
locateCmd "jq"

INPUT_NAME=$(echo -n "${INPUT_NAME}" | jq -sRr @uri) # to url-encoded
INPUT_PROF=$(eval realpath "${INPUT_PROF}")
BASE_INPUT_PROF=$(basename "${INPUT_PROF}")
BASE_INPUT_PROF=$(echo -n "${BASE_INPUT_PROF}" | jq -sRr @uri) # to url-encoded

upload=$(curl --data-binary "@${INPUT_PROF}" "https://flamegraph.com/?name=${INPUT_NAME}&file_name=${BASE_INPUT_PROF}")

flamegraph_key=$(jq -r '.key | walk(if . == null then "" else . end)' <<< "${upload}")
flamegraph_url=$(jq -r '.url | walk(if . == null then "" else . end)' <<< "${upload}")
flamegraph_message=$(jq -r '.message | walk(if . == null then "" else . end)' <<< "${upload}")

{
    echo "key=${flamegraph_key}"
    echo "url=${flamegraph_url}"
    echo "message=${flamegraph_message}"
} >> $GITHUB_OUTPUT

if [[ -n "${flamegraph_message}" ]]; then
    echo "::error::${flamegraph_message}"
    exit 1
fi