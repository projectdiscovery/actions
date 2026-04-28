import path from 'node:path'

import * as core from '@actions/core'
import * as github from '@actions/github'
import * as tc from '@actions/tool-cache'

function requiredEnv(name) {
  const value = process.env[name]

  if (value === undefined) {
    throw new Error(`Missing required environment variable: ${name}`)
  }

  return value
}

export default async function download({ version, token }) {
  const runnerOs = requiredEnv('RUNNER_OS')
  const runnerArch = requiredEnv('RUNNER_ARCH')
  const workspace = requiredEnv('GITHUB_WORKSPACE')
  const os = runnerOs === 'macOS' ? 'macOS' : runnerOs.toLowerCase()
  const arch = runnerArch.toLowerCase()
    .replace('x86', '386')
    .replace('x64', 'amd64')
  const repo = { owner: 'projectdiscovery', repo: 'nuclei' }
  const octokit = github.getOctokit(token)

  try {
    if (version === 'latest') {
      core.debug('Getting latest release...')
      const latestRelease = await octokit.rest.repos.getLatestRelease(repo)
      version = latestRelease.data.tag_name
      core.debug(`Found latest release: ${version}`)
    } else {
      core.debug(`Getting "${version}" tag...`)
      await octokit.rest.repos.getReleaseByTag({...repo, tag: version})
    }
  } catch (error) {
    throw new Error(`Could not get "${version}" tag: ${error.message}`)
  }

  const asset = `nuclei_${version.replace(/^v/, '')}_${os}_${arch}.zip`
  const assetURL = `https://github.com/${repo.owner}/${repo.repo}/releases/download/${version}/${asset}`

  core.debug(`Checking cache for nuclei...`)
  let nucleiPath = tc.find('nuclei', version, arch)

  if (nucleiPath) {
    core.notice(`nuclei ${version} found in cache`)
  } else {
    nucleiPath = path.join(workspace, '../', 'nuclei')

    let zipPath
    try {
      core.debug(`Downloading nuclei ${version} for ${os}/${arch}...`)
      zipPath = await tc.downloadTool(assetURL)
    } catch (error) {
      throw new Error(`Could not download nuclei: ${error.message}`)
    }

    let extractedPath
    try {
      core.debug('Extracting nuclei...')
      extractedPath = await tc.extractZip(zipPath, nucleiPath)
    } catch (error) {
      throw new Error(`Could not extract nuclei: ${error.message}`)
    }

    core.debug('Caching nuclei...')
    nucleiPath = await tc.cacheDir(extractedPath, 'nuclei', version, arch)
  }

  core.debug('Adding nuclei to PATH...')
  core.addPath(nucleiPath)
  core.info(`nuclei ${version} has been installed successfully`)
}