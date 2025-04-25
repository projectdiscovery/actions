## Description

Run GolangCI Lint v2

## Inputs

| name | description | required | default |
| --- | --- | --- | --- |
| `version` | <p>GolangCI Lint version</p> | `false` | `latest` |
| `args` | <p>Run with arguments</p> | `false` | `--timeout=30m` |


## Runs

This action is a `composite` action.

## Usage

```yaml
- uses: projectdiscovery/actions/golangci-lint/v2@v1
  with:
    version:
    # GolangCI Lint version
    #
    # Required: false
    # Default: latest

    args:
    # Run with arguments
    #
    # Required: false
    # Default: --timeout=30m
```



