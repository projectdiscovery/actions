## Description

Get the pull request number associated with the current workflow run.

## Inputs

| name | description | required | default |
| --- | --- | --- | --- |
| `token` | <p>GitHub token with <code>pull-requests: read</code> permission.</p> | `true` | `${{ github.token }}` |


## Outputs

| name | description |
| --- | --- |
| `number` | <p>The detected PR number.</p> |


## Runs

This action is a `composite` action.

## Usage

```yaml
- uses: projectdiscovery/actions/pr/get-pr-number@v1
  with:
    token:
    # GitHub token with `pull-requests: read` permission.
    #
    # Required: true
    # Default: ${{ github.token }}
```



