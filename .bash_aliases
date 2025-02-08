# Usage:
# `source <(curl -fsSL "https://github.com/projectdiscovery/actions/raw/refs/heads/dotfiles/.bash_aliases")`

printDebug() {
    echo "::debug::${1}"
}

printNotice() {
    echo "::notice::${1}"
}

printWarning() {
    echo "::warning::${1}"
}

printError() {
    echo "::error::${1}"
}

printErrorWithExit() {
    printError "${1}"
    exit "${2}"
}

cmdMustExists() {
    which $1 >/dev/null || printErrorWithExit "Could not find $1" "1"
}

fileMustExists() {
    test ! -e "$1" && printErrorWithExit "Could not find file $1" "1" || true
}

runnerOSMustLinux() {
    [[ "${RUNNER_OS}" == "Linux" ]] || printErrorWithExit "Runner OS must Linux" "1"
}

runnerOSMustWindows() {
    [[ "${RUNNER_OS}" == "Windows" ]] || printErrorWithExit "Runner OS must Windows" "1"
}

runnerOSMustDarwin() {
    [[ "${RUNNER_OS}" == "macOS" ]] || printErrorWithExit "Runner OS must macOS" "1"
}

toURLEncoded() {
    cmdMustExists "jq"
    echo -n "${1}" | jq -sRr @uri
}

toSlug() {
    echo -n "${1}" | tr -c '[:alnum:]' '-' | tr '[:upper:]' '[:lower:]' | sed 's/^-*//;s/-*$//;s/-\\+/-/g'
}