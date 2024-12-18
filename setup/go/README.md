## Description

Run actions/setup-go

## Inputs

| name | description | required | default |
| --- | --- | --- | --- |
| `go-version` | <p>Setup with specific version</p> | `false` | `""` |


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
```



