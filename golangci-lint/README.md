## Description

Run GolangCI Lint

## Inputs

| name | description | required | default |
| --- | --- | --- | --- |
| `args` | <p>Run with arguments</p> | `false` | `--timeout=30m` |


## Runs

This action is a `composite` action.

## Usage

```yaml
- uses: projectdiscovery/actions/golangci-lint@v1
  with:
    args:
    # Run with arguments
    #
    # Required: false
    # Default: --timeout=30m
```



