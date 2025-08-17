#!/bin/bash

set -euo pipefail

source <(curl -fsSL "https://github.com/projectdiscovery/actions/raw/refs/heads/dotfiles/.bash_aliases")

INPUT_TEMPLATES="${INPUT_TEMPLATES:-}"
INPUT_SEPARATOR="${INPUT_SEPARATOR:- }"

if [[ -z "${INPUT_TEMPLATES}" ]]; then
    printErrorWithExit "No templates specified" 1
fi

IFS="${INPUT_SEPARATOR}" read -ra template_array <<< "${INPUT_TEMPLATES}"

echo "::group::Resolving templates"
resolved_templates=()
for template in "${template_array[@]}"; do
    if [[ -e "${template}" ]]; then
        resolved_templates+=("$(realpath "${template}")")
    else
        printError "Template path '${template}' does not exist" 1
    fi
done
echo "::endgroup::"

templates=$(IFS=','; echo "${resolved_templates[*]}")

echo "::group::Validating templates"
nuclei -disable-update-check -enable-self-contained -enable-global-matchers \
    -code -file -dast -validate -templates "${templates}"
echo "::endgroup::"
