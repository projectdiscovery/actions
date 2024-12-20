## Description

Install Nuclei engine

## Inputs

| name | description | required | default |
| --- | --- | --- | --- |
| `version` | <p>Setup with specific version ("latest" or in format "vX.Y.Z")</p> | `true` | `latest` |
| `token` | <p>GitHub Token</p> | `true` | `""` |


## Runs

This action is a `composite` action.

## Usage

```yaml
- uses: projectdiscovery/actions/setup/nuclei@v1
  with:
    version:
    # Setup with specific version ("latest" or in format "vX.Y.Z")
    #
    # Required: true
    # Default: latest

    token:
    # GitHub Token
    #
    # Required: true
    # Default: ""
```



