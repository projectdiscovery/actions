## Description

Run caarlos0/svu - next version based on git history

## Inputs

| name | description | required | default |
| --- | --- | --- | --- |
| `token` | <p>GitHub Token</p> | `true` | `${{ github.token }}` |
| `always` | <p>if no commits trigger a version change, increment the patch</p> | `false` | `false` |
| `log-directory` | <p>only use commits that changed files in the given directories</p> | `false` | `""` |
| `metadata` | <p>sets the version metadata</p> | `false` | `""` |
| `prerelease` | <p>sets the version prerelease</p> | `false` | `""` |
| `tag-mode` | <p>determine if it should look for tags in all branches, or just the current one</p> | `false` | `all` |
| `tag-pattern` | <p>ignore tags that do not match the given pattern</p> | `false` | `""` |
| `tag-prefix` | <p>sets a tag custom prefix</p> | `false` | `v` |
| `v0` | <p>prevent major version increments if current version is still v0</p> | `false` | `""` |


## Outputs

| name | description |
| --- | --- |
| `tag` | <p>The new created and pushed tag</p> |


## Runs

This action is a `composite` action.

## Usage

```yaml
- uses: projectdiscovery/actions/svu-next@v1
  with:
    token:
    # GitHub Token
    #
    # Required: true
    # Default: ${{ github.token }}

    always:
    # if no commits trigger a version change, increment the patch
    #
    # Required: false
    # Default: false

    log-directory:
    # only use commits that changed files in the given directories
    #
    # Required: false
    # Default: ""

    metadata:
    # sets the version metadata
    #
    # Required: false
    # Default: ""

    prerelease:
    # sets the version prerelease
    #
    # Required: false
    # Default: ""

    tag-mode:
    # determine if it should look for tags in all branches, or just the current one
    #
    # Required: false
    # Default: all

    tag-pattern:
    # ignore tags that do not match the given pattern
    #
    # Required: false
    # Default: ""

    tag-prefix:
    # sets a tag custom prefix
    #
    # Required: false
    # Default: v

    v0:
    # prevent major version increments if current version is still v0
    #
    # Required: false
    # Default: ""
```



