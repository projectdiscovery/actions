const dl = require('./download')
const core = require('@actions/core')
const token = process.env.INPUT_TOKEN
const version = process.env.INPUT_VERSION

if (version !== 'latest' && !version.match(/^v\d+\.\d+\.\d+$/)) {
  core.setFailed('Version must be "latest" or in format "vX.Y.Z"')
  process.exit(1)
}

await dl({version, token})