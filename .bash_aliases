function printDebug() {
    echo "::debug::${1}"
}

function printNotice() {
    echo "::notice::${1}"
}

function printWarning() {
    echo "::warning::${1}"
}

function printError() {
    echo "::error::${1}"
}

function printErrorWithExit() {
    printError "${1}"
    exit "${2}"
}

function cmdMustExists() {
    which $1 >/dev/null || printErrorWithExit "Could not find $1" "1"
}

function fileMustExists() {
    test ! -e "$1" && printErrorWithExit "Could not find file $1" "1" || true
}

function runnerOSMustLinux() {
    [[ "${RUNNER_OS}" == "Linux" ]] || printErrorWithExit "Runner OS must Linux" "1"
}

function runnerOSMustWindows() {
    [[ "${RUNNER_OS}" == "Windows" ]] || printErrorWithExit "Runner OS must Windows" "1"
}

function runnerOSMustDarwin() {
    [[ "${RUNNER_OS}" == "macOS" ]] || printErrorWithExit "Runner OS must macOS" "1"
}