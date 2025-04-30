## Description

Parse semantic versioning strings

## Inputs

| name | description | required | default |
| --- | --- | --- | --- |
| `tag` | <p>Tag to parse (defaults to latest tag)</p> | `false` | `""` |


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
```



