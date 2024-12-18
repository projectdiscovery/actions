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
	local tag="$(git describe --tags --abbrev=0 | cut -d '.' -f1)"

	# rm if exists
	[[ -f "${doc}" ]] && rm -rf "${doc}"
	action-docs --no-banner --source "${src}" > "${doc}"

	# replace placeholders
	sed -i -e "s|\*\*\*PROJECT\*\*\*|${GITHUB_REPOSITORY}/${dir##./}|g" "${doc}"
	sed -i -e "s|\*\*\*VERSION\*\*\*|${tag}|g" "${doc}"

	[[ "$(git status -s | wc -l)" -gt "0" ]] && commit "${dir}"
}

generateDocs "${1}"