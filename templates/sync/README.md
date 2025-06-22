## Description

Early nuclei templates synchronize

## Inputs

| name | description | required | default |
| --- | --- | --- | --- |
| `token` | <p>GitHub Token</p> | `true` | `{{ github.token }}` |


## Runs

This action is a `composite` action.

## Usage

```yaml
- uses: projectdiscovery/actions/templates/sync@v1
  with:
    token:
    # GitHub Token
    #
    # Required: true
    # Default: {{ github.token }}
```



