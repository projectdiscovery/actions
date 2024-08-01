## Description

Configure user's name & email for git

## Inputs

| name | description | required | default |
| --- | --- | --- | --- |
| `scope` | <p>Scope for configured git user</p> | `true` | `local` |
| `username` | <p>GitHub username</p> | `false` | `ghost` |


## Outputs

| name | description |
| --- | --- |
| `email` | <p>Configured git user's email</p> |


## Runs

This action is a `composite` action.

## Usage

```yaml
- uses: ***PROJECT***@***VERSION***
  with:
    scope:
    # Scope for configured git user
    #
    # Required: true
    # Default: local

    username:
    # GitHub username
    #
    # Required: false
    # Default: ghost
```



