## Description

Upgrade Go dependencies that have known vulnerabilities to versions that fix them

## Inputs

| name | description | required | default |
| --- | --- | --- | --- |
| `args` | <p>Run with arguments (flags and patterns)</p> | `false` | `""` |
| `working-directory` | <p>Directory of the module to upgrade</p> | `false` | `.` |
| `create-pr` | <p>Commit the upgrades and open or update a pull request with govulnbump's report</p> | `false` | `false` |
| `pr-args` | <p>Flags for <code>gh pr create</code> when create-pr opens a new pull request, such as <code>--label</code>, <code>--assignee</code>, <code>--reviewer</code>, <code>--milestone</code> or <code>--draft</code></p> | `false` | `""` |
| `token` | <p>GitHub token for create-pr, with <code>contents: write</code> and <code>pull-requests: write</code> permissions</p> | `false` | `${{ github.token }}` |


## Outputs

| name | description |
| --- | --- |
| `exit-code` | <p>govulnbump exit code: 0 if no vulnerabilities remain, 1 on error, 2 if the command line is invalid, 3 if vulnerabilities remain</p> |


## Runs

This action is a `composite` action.

## Usage

```yaml
- uses: projectdiscovery/actions/govulnbump@v1
  with:
    args:
    # Run with arguments (flags and patterns)
    #
    # Required: false
    # Default: ""

    working-directory:
    # Directory of the module to upgrade
    #
    # Required: false
    # Default: .

    create-pr:
    # Commit the upgrades and open or update a pull request with govulnbump's report
    #
    # Required: false
    # Default: false

    pr-args:
    # Flags for `gh pr create` when create-pr opens a new pull request, such as `--label`, `--assignee`, `--reviewer`, `--milestone` or `--draft`
    #
    # Required: false
    # Default: ""

    token:
    # GitHub token for create-pr, with `contents: write` and `pull-requests: write` permissions
    #
    # Required: false
    # Default: ${{ github.token }}
```



