module.exports = async ({github, context, core}) => {
  let version = process.env.INPUT_VERSION
  const path = require('path')
  const tc = require('@actions/tool-cache')
  const os = process.env.RUNNER_OS === "macOS" || process.env.RUNNER_OS.toLowerCase()
  const arch = process.env.RUNNER_ARCH.toLowerCase()
    .replace('x86', '386')
    .replace('x64', 'amd64')
  const repo = {owner: 'projectdiscovery', repo: 'nuclei'}

  if (version !== 'latest' && !version.match(/^v\d+\.\d+\.\d+$/)) {
    core.setFailed('Version must be "latest" or in format "vX.Y.Z"')
    process.exit(1)
  }

  if (version === 'latest') {
    const latestRelease = await github.rest.repos.getLatestRelease(repo)
    version = latestRelease.data.tag_name
  } else {
    try {
      await github.rest.repos.getReleaseByTag({...repo, tag: version})
    } catch (error) {
      core.setFailed(`Could not get "${version}" tag: ${error.message}`)
      process.exit(1)
    }
  }

  const asset = `nuclei_${version}_${os}_${arch}.zip`
  const assetURL = `https://github.com/${repo.owner}/${repo.repo}/releases/download/${version}/${asset}`

  core.debug(`Checking cache for nuclei...`)
  let nucleiPath = tc.find('nuclei', version, arch)

  if (!nucleiPath) {
    nucleiPath = path.join(process.env.GITHUB_WORKSPACE, '../', 'nuclei')

    let zipPath
    try {
      core.debug(`Downloading nuclei ${version} for ${os}/${arch}...`)
      zipPath = await tc.downloadTool(assetURL)
    } catch (error) {
      core.setFailed(`Could not download nuclei: ${error.message}`)
      process.exit(1)
    }

    let extractedPath
    try {
      core.debug('Extracting nuclei...')
      extractedPath = await tc.extractZip(zipPath, nucleiPath)
    } catch (error) {
      core.setFailed(`Could not extract nuclei: ${error.message}`)
      process.exit(1)
    }

    core.debug('Caching nuclei...')
    nucleiPath = await tc.cacheDir(extractedPath, 'nuclei', version, arch)
  }

  core.debug('Adding nuclei to PATH...')
  core.addPath(nucleiPath)
}