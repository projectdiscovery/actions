## Description

Automatically approve a pull request.

## Inputs

| name | description | required | default |
| --- | --- | --- | --- |
| `token` | <p>GitHub token with <code>pull-requests: write</code> permission.</p> | `true` | `${{ github.token }}` |
| `username` | <p>GitHub username associated with the token.</p> | `false` | `${{ github.actor }}` |
| `repository` | <p>Repository in owner/repo format.</p> | `true` | `${{ github.repository }}` |
| `pr-number` | <p>PR number to approve. If not provided, it will be auto-detected from the event context.</p> | `false` | `""` |
| `approve-message` | <p>Message for PR approval.</p> | `false` | `_Automatically approved using projectdiscovery/actions/pr/approve action._` |


## Outputs

| name | description |
| --- | --- |
| `approved` | <p>Indicates whether the PR was approved.</p> |
| `pr-number` | <p>The PR number that was approved.</p> |


## Runs

This action is a `composite` action.

## Usage

```yaml
- uses: projectdiscovery/actions/pr/approve@v1
  with:
    token:
    # GitHub token with `pull-requests: write` permission.
    #
    # Required: true
    # Default: ${{ github.token }}

    username:
    # GitHub username associated with the token.
    #
    # Required: false
    # Default: ${{ github.actor }}

    repository:
    # Repository in owner/repo format.
    #
    # Required: true
    # Default: ${{ github.repository }}

    pr-number:
    # PR number to approve. If not provided, it will be auto-detected from the event context.
    #
    # Required: false
    # Default: ""

    approve-message:
    # Message for PR approval.
    #
    # Required: false
    # Default: _Automatically approved using projectdiscovery/actions/pr/approve action._
```



