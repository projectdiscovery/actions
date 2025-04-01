## Description

Run compatibility checks for Go projects

## Inputs

| name | description | required | default |
| --- | --- | --- | --- |
| `go-version` | <p>Setup with specific version</p> | `false` | `""` |
| `go-version-file` | <p>Path to go version file</p> | `false` | `""` |
| `release-test` | <p>Run release test (with goreleaser)</p> | `false` | `false` |


## Runs

This action is a `composite` action.

## Usage

```yaml
- uses: projectdiscovery/actions/setup/go/compat-checks@v1
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
    # Default: ""

    release-test:
    # Run release test (with goreleaser)
    #
    # Required: false
    # Default: false
```



