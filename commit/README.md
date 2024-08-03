## Description

Run git-commit

## Inputs

| name | description | required | default |
| --- | --- | --- | --- |
| `files` | <p>Files to commit (newline-separated)</p> | `true` | `.` |
| `message` | <p>Commit message</p> | `true` | `""` |


## Runs

This action is a `composite` action.

## Usage

```yaml
- uses: ***PROJECT***@***VERSION***
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
```



