const core = require('@actions/core')
const exec = require('@actions/exec')
const github = require('@actions/github')
const context = JSON.parse(process.env.GITHUB_CONTEXT)
const currentTag = process.env.CURRENT_TAG.trim()
const token = process.env.INPUT_TOKEN
const always = (process.env.INPUT_ALWAYS === 'true')
const logDirectory = process.env.INPUT_LOG_DIRECTORY
const metadata = process.env.INPUT_METADATA
const prerelease = process.env.INPUT_PRERELEASE
const tagMode = process.env.INPUT_TAG_MODE
const tagPattern = process.env.INPUT_TAG_PATTERN
const tagPrefix = process.env.INPUT_TAG_PREFIX
const v0 = (process.env.INPUT_V0 === 'true')
const setFailed = (process.env.INPUT_SET_FAILED === 'true')
const releaseCreate = (process.env.INPUT_RELEASE_CREATE === 'true')
const releaseName = process.env.INPUT_RELEASE_NAME
const releaseDraft = (process.env.INPUT_RELEASE_DRAFT === 'true')
const releaseMakeLatest = (process.env.INPUT_RELEASE_MAKE_LATEST === 'true')

async function main() {
  if (currentTag === '') throw new Error('No current tag found.')

  core.debug("Setting up Octokit...")
  const octokit = github.getOctokit(token)

  let nextVersion = ''
  let nextVersionErr = ''
  const nextVersionOptions = {
    cwd: process.env.GITHUB_WORKSPACE,
    listeners: {
      stdout: (data) => nextVersion += data.toString(),
      stderr: (data) => nextVersionErr += data.toString()
    }
  }
  await exec.exec('svu', [
    'next',
    `${always ? '--always' : ''}`,
    `--log.directory=${logDirectory}`,
    `--metadata=${metadata}`,
    `--prerelease=${prerelease}`,
    `--tag.mode=${tagMode}`,
    `--tag.pattern=${tagPattern}`,
    `--tag.prefix=${tagPrefix}`,
    `${v0 ? '--v0' : ''}`,
  ], nextVersionOptions)

  if (nextVersionErr) throw new Error(`Error: ${nextVersionErr}`);
  nextVersion = nextVersion.trim()
  core.info(`next version tag: ${nextVersion}`)

  if (nextVersion === currentTag) {
    throw new Error(`Current tag is already ${nextVersion}, skipping.`)
  }

  core.info(`Creating and pushing tag ${nextVersion}...`)
  const [owner, repo] = context.repository.split('/')
  const tag = await octokit.rest.git.createTag({
    owner: owner,
    repo: repo,
    tag: nextVersion,
    message: 'Automatically tagged using projectdiscovery/actions/svu-next action.',
    object: context.sha,
    type: 'commit',
    tagger: {
      name: context.triggering_actor,
      email: `${context.actor_id}+${context.triggering_actor}@users.noreply.github.com`,
    }
  })

  await octokit.rest.git.createRef({
    owner: owner,
    repo: repo,
    ref: `refs/tags/${nextVersion}`,
    sha: tag.data.sha
  })

  core.info(`Tag ${nextVersion} created and pushed successfully.`)

  if (releaseCreate) {
    core.info(`Creating release for tag ${nextVersion}...`)
    await octokit.rest.repos.createRelease({
      owner: owner,
      repo: repo,
      tag_name: nextVersion,
      name: releaseName,
      body: `_Automatically released using projectdiscovery/actions/svu-next action._\n\n---\n`,
      draft: releaseDraft,
      prerelease: (prerelease !== '' && prerelease !== undefined),
      generate_release_notes: true,
      make_latest: releaseMakeLatest ? 'true' : 'false'
    })
    core.info(`Release for tag ${nextVersion} created successfully.`)
  }

  core.setOutput('tag', nextVersion)
}

main().catch((error) => {
  if (setFailed) {
    core.setFailed(error.message)
  }
  else {
    core.warning(error.message)
  }
})
