## Description

Run actions/setup-go

## Inputs

| name | description | required | default |
| --- | --- | --- | --- |
| `go-version` | <p>Setup with specific version</p> | `false` | `""` |
| `go-version-file` | <p>Path to go version file</p> | `false` | `go.mod` |


## Runs

This action is a `composite` action.

## Usage

```yaml
- uses: projectdiscovery/actions/setup/go@v1
  with:
    go-version:
    # Setup with specific version
    #
    # Required: false
    # Default: ""

    go-version-file:
    # Path to go version file
    #
    # Required: false
    # Default: go.mod
```



