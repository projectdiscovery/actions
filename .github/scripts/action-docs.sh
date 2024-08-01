#!/bin/bash

function commit() {
	local scope="$(basename "${1}")"

	git add "${1}"
	git commit -m "docs(${scope}): update README 🤖"
}

function generateDocs() {
	local src="${1}"
	local dir="$(dirname "${1}")"
	local doc="${dir}/README.md"

	# rm if exists
	[[ -f "${doc}" ]] && rm -rf "${doc}"

	action-docs --no-banner --source "${src}" > "${doc}"

	[[ "$(git status -s | wc -l)" -gt "0" ]] && commit "${dir}"
}

generateDocs "${1}"