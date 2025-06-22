## Description

Install TemplateMan CLI

## Inputs

| name | description | required | default |
| --- | --- | --- | --- |
| `token` | <p>GitHub Token</p> | `true` | `{{ github.token }}` |
| `version` | <p>Setup with specific version</p> | `false` | `latest` |
| `go-version` | <p>Specify Go version</p> | `false` | `stable` |


## Runs

This action is a `composite` action.

## Usage

```yaml
- uses: projectdiscovery/actions/setup/templateman@v1
  with:
    token:
    # GitHub Token
    #
    # Required: true
    # Default: {{ github.token }}

    version:
    # Setup with specific version
    #
    # Required: false
    # Default: latest

    go-version:
    # Specify Go version
    #
    # Required: false
    # Default: stable
```



