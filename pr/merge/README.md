## Description

Automatically merge a pull request.

## Inputs

| name | description | required | default |
| --- | --- | --- | --- |
| `token` | <p>GitHub token with <code>pull-requests: write</code> permission.</p> | `true` | `${{ github.token }}` |
| `username` | <p>GitHub username associated with the token.</p> | `false` | `${{ github.actor }}` |
| `repository` | <p>Repository in owner/repo format.</p> | `true` | `${{ github.repository }}` |
| `pr-number` | <p>PR number to merge. If not provided, it will be auto-detected from the event context.</p> | `false` | `""` |
| `merge-method` | <p>Merge method (merge, squash, rebase).</p> | `false` | `squash` |
| `delete-branch` | <p>Delete branch after merge.</p> | `false` | `true` |
| `auto` | <p>Enable GitHub auto-merge (automatically merge ONLY after necessary requirements are met).</p> | `false` | `true` |


## Outputs

| name | description |
| --- | --- |
| `merged` | <p>Indicates whether the PR was merged.</p> |
| `pr-number` | <p>The PR number that was merged.</p> |


## Runs

This action is a `composite` action.

## Usage

```yaml
- uses: projectdiscovery/actions/pr/merge@v1
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
    # PR number to merge. If not provided, it will be auto-detected from the event context.
    #
    # Required: false
    # Default: ""

    merge-method:
    # Merge method (merge, squash, rebase).
    #
    # Required: false
    # Default: squash

    delete-branch:
    # Delete branch after merge.
    #
    # Required: false
    # Default: true

    auto:
    # Enable GitHub auto-merge (automatically merge ONLY after necessary requirements are met).
    #
    # Required: false
    # Default: true
```



