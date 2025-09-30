const dl = require('./download')
const core = require('@actions/core')
const exec = require('@actions/exec')
const token = process.env.INPUT_TOKEN
const version = process.env.INPUT_VERSION

try {
  const command = process.platform === 'win32' ? 'where' : 'which'
  await exec.exec(command, ['nuclei'], { silent: true })

  core.info('nuclei is already installed and available in PATH')
  process.exit(0)
} catch (_) {
  // nuclei not found in PATH, continue with installation
}

if (version !== 'latest' && !version.match(/^v\d+\.\d+\.\d+$/)) {
  core.setFailed('Version must be "latest" or in format "vX.Y.Z"')
  process.exit(1)
}

try {
  await dl({version, token})
} catch (error) {
  core.setFailed(error.message)
  process.exit(1)
}