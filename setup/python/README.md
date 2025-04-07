## Description

Run actions/setup-python

## Inputs

| name | description | required | default |
| --- | --- | --- | --- |
| `python-version` | <p>Setup with specific version</p> | `false` | `3.10` |


## Runs

This action is a `composite` action.

## Usage

```yaml
- uses: projectdiscovery/actions/setup/python@v1
  with:
    python-version:
    # Setup with specific version
    #
    # Required: false
    # Default: 3.10
```



