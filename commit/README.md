## Description

Run git-commit

## Inputs

| name | description | required | default |
| --- | --- | --- | --- |
| `files` | <p>Files to commit (newline-separated)</p> | `true` | `.` |
| `message` | <p>Commit message</p> | `true` | `""` |
| `push` | <p>Push after successfully creating a commit</p> | `false` | `false` |


## Runs

This action is a `composite` action.

## Usage

```yaml
- uses: projectdiscovery/actions/commit@v1
  with:
    files:
    # Files to commit (newline-separated)
    #
    # Required: true
    # Default: .

    message:
    # Commit message
    #
    # Required: true
    # Default: ""

    push: false
    # Push after successfully creating a commit
    #
    # Required: false
    # Default: false
```



