## Description

Run GolangCI Lint

## Inputs

| name | description | required | default |
| --- | --- | --- | --- |
| `version` | <p>GolangCI Lint version</p> | `false` | `v1.64.8` |
| `args` | <p>Run with arguments</p> | `false` | `--timeout=30m` |


## Runs

This action is a `composite` action.

## Usage

```yaml
- uses: projectdiscovery/actions/golangci-lint@v1
  with:
    version:
    # GolangCI Lint version
    #
    # Required: false
    # Default: v1.64.8

    args:
    # Run with arguments
    #
    # Required: false
    # Default: --timeout=30m
```



