#!/usr/bin/env bash

set -euo pipefail

default_key_name() {
    local repo_name=""

    if [[ -n "${GITHUB_REPOSITORY:-}" ]]; then
        repo_name="${GITHUB_REPOSITORY##*/}"
    elif [[ -n "${GITHUB_WORKSPACE:-}" ]]; then
        repo_name="$(basename "${GITHUB_WORKSPACE}")"
    else
        repo_name="$(basename "${PWD}")"
    fi

    if [[ -z "${repo_name}" ]]; then
        repo_name="key"
    fi

    printf '%s\n' "${repo_name}"
}

resolve_output_path() {
    local path="${1}"

    if [[ -z "${path}" ]]; then
        echo ""
        return
    fi

    if [[ "${path}" = /* ]]; then
        printf '%s\n' "${path}"
        return
    fi

    printf '%s/%s\n' "${PWD}" "${path}"
}

gpg_bin="$(command -v gpg2 || command -v gpg || true)"
if [[ -z "${gpg_bin}" ]]; then
    echo "::error::gpg is not installed on this runner"
    exit 1
fi

default_key_basename="$(default_key_name)"
INPUT_EXPIRE="${INPUT_EXPIRE:-0}"
INPUT_PUBLIC_KEY_PATH="${INPUT_PUBLIC_KEY_PATH:-${default_key_basename}.pub.asc}"
INPUT_PRIVATE_KEY_PATH="${INPUT_PRIVATE_KEY_PATH:-${default_key_basename}.priv.asc}"

for field in INPUT_NAME INPUT_EMAIL INPUT_EXPIRE INPUT_PASSPHRASE INPUT_PUBLIC_KEY_PATH INPUT_PRIVATE_KEY_PATH; do
    if [[ "${!field}" == *$'\n'* ]]; then
        echo "::error::${field} must not contain newlines"
        exit 1
    fi
done

tmpdir="$(mktemp -d)"
gnupg_home="${tmpdir}/gnupg"
batch_file="${tmpdir}/genkey"
public_key_path="$(resolve_output_path "${INPUT_PUBLIC_KEY_PATH}")"
private_key_path="$(resolve_output_path "${INPUT_PRIVATE_KEY_PATH}")"

if [[ -z "${public_key_path}" || -z "${private_key_path}" ]]; then
    echo "::error::public and private key paths must not be empty"
    exit 1
fi

cleanup() {
    rm -rf "${tmpdir}"
}
trap cleanup EXIT

umask 077
mkdir -p "${gnupg_home}"
chmod 700 "${gnupg_home}"
mkdir -p "$(dirname "${public_key_path}")"
mkdir -p "$(dirname "${private_key_path}")"

{
    printf '%%echo Generating key\n'
    printf 'Key-Type: RSA\n'
    printf 'Key-Length: 4096\n'
    printf 'Subkey-Type: RSA\n'
    printf 'Subkey-Length: 4096\n'
    printf 'Name-Real: %s\n' "${INPUT_NAME}"
    printf 'Name-Email: %s\n' "${INPUT_EMAIL}"
    printf 'Expire-Date: %s\n' "${INPUT_EXPIRE}"

    if [[ -n "${INPUT_PASSPHRASE}" ]]; then
        printf 'Passphrase: %s\n' "${INPUT_PASSPHRASE}"
    else
        printf '%%no-protection\n'
    fi

    printf '%%commit\n'
} > "${batch_file}"

generate_args=(--batch --yes)
secret_export_args=(--batch --yes --armor --export-secret-keys "${INPUT_EMAIL}")

if [[ -n "${INPUT_PASSPHRASE}" ]]; then
    generate_args+=(--pinentry-mode loopback)
    secret_export_args=(--batch --yes --pinentry-mode loopback --passphrase "${INPUT_PASSPHRASE}" --armor --export-secret-keys "${INPUT_EMAIL}")
fi

GNUPGHOME="${gnupg_home}" "${gpg_bin}" "${generate_args[@]}" --gen-key "${batch_file}"
GNUPGHOME="${gnupg_home}" "${gpg_bin}" --batch --yes --armor --export "${INPUT_EMAIL}" > "${public_key_path}"
GNUPGHOME="${gnupg_home}" "${gpg_bin}" "${secret_export_args[@]}" > "${private_key_path}"

{
    echo "public-key-path=${public_key_path}"
    echo "private-key-path=${private_key_path}"
} >> "${GITHUB_OUTPUT}"