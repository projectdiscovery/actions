import * as core from '@actions/core'
import * as exec from '@actions/exec'
import download from './download.js'

function requiredEnv(name) {
  const value = process.env[name]

  if (value === undefined) {
    throw new Error(`Missing required environment variable: ${name}`)
  }

  return value
}

async function main() {
  const token = requiredEnv('INPUT_TOKEN')
  const version = requiredEnv('INPUT_VERSION')

  try {
    const command = process.platform === 'win32' ? 'where' : 'which'
    await exec.exec(command, ['nuclei'], { silent: true })

    core.info('nuclei is already installed and available in PATH')
    return
  } catch (_) {
    // nuclei not found in PATH, continue with installation
  }

  if (version !== 'latest' && !/^v\d+\.\d+\.\d+$/.test(version)) {
    throw new Error('Version must be "latest" or in format "vX.Y.Z"')
  }

  await download({ version, token })
}

main().catch((error) => {
  core.setFailed(error.message)
  process.exit(1)
})