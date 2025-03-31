## Description

Run compatibility checks for Go projects

## Inputs

| name | description | required | default |
| --- | --- | --- | --- |
| `release-test` | <p>Run release test (with goreleaser)</p> | `false` | `false` |


## Runs

This action is a `composite` action.

## Usage

```yaml
- uses: projectdiscovery/actions/setup/go/compatibility-checks@v1
  with:
    release-test:
    # Run release test (with goreleaser)
    #
    # Required: false
    # Default: false
```



