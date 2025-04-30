## Description

Parse semantic versioning strings

## Inputs

| name | description | required | default |
| --- | --- | --- | --- |
| `tag` | <p>Tag to parse (defaults to latest tag)</p> | `false` | `""` |
| `allow-no-tags` | <p>If true and no tags are found, fallback to version 0.0.0</p> | `false` | `false` |


## Outputs

| name | description |
| --- | --- |
| `major` | <p>Major version</p> |
| `minor` | <p>Minor version</p> |
| `patch` | <p>Patch version</p> |
| `special` | <p>Special version</p> |
| `version` | <p>Full version (without prefix and excluding special version)</p> |


## Runs

This action is a `composite` action.

## Usage

```yaml
- uses: projectdiscovery/actions/semver@v1
  with:
    tag:
    # Tag to parse (defaults to latest tag)
    #
    # Required: false
    # Default: ""

    allow-no-tags:
    # If true and no tags are found, fallback to version 0.0.0
    #
    # Required: false
    # Default: false
```



