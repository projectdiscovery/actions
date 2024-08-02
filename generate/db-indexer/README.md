## Description

Generate Nuclei Templates Database Indexer

## Inputs

| name | description | required | default |
| --- | --- | --- | --- |
| `token` | <p>GitHub Token</p> | `true` | `""` |
| `version` | <p>Setup with specific version</p> | `false` | `latest` |
| `mode` | <p>Specify mode of operation (templates/changelog)</p> | `true` | `templates` |
| `args` | <p>Specify additional arguments</p> | `false` | `""` |
| `go-version` | <p>Specify Go version</p> | `false` | `stable` |


## Runs

This action is a `composite` action.

## Usage

```yaml
- uses: ***PROJECT***@***VERSION***
  with:
    token:
    # GitHub Token
    #
    # Required: true
    # Default: ""

    version:
    # Setup with specific version
    #
    # Required: false
    # Default: latest

    mode:
    # Specify mode of operation (templates/changelog)
    #
    # Required: true
    # Default: templates

    args:
    # Specify additional arguments
    #
    # Required: false
    # Default: ""

    go-version:
    # Specify Go version
    #
    # Required: false
    # Default: stable
```



