## Description

Extracting various meta data from nuclei-templates

## Inputs

| name | description | required | default |
| --- | --- | --- | --- |
| `version` | <p>Setup with specific version</p> | `false` | `latest` |
| `path` | <p>Path to Nuclei templates directory</p> | `false` | `""` |
| `output` | <p>File to write template addition author output</p> | `false` | `""` |
| `args` | <p>Specify additional arguments</p> | `false` | `""` |
| `go-version` | <p>Specify Go version</p> | `false` | `stable` |


## Runs

This action is a `composite` action.

## Usage

```yaml
- uses: ***PROJECT***@***VERSION***
  with:
    version:
    # Setup with specific version
    #
    # Required: false
    # Default: latest

    path:
    # Path to Nuclei templates directory
    #
    # Required: false
    # Default: ""

    output:
    # File to write template addition author output
    #
    # Required: false
    # Default: ""

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



