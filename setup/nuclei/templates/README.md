## Description

Download Nuclei templates

## Inputs

| name | description | required | default |
| --- | --- | --- | --- |
| `version` | <p>Download specific version (latest, stable, vX.Y.Z)</p> | `true` | `stable` |
| `target` | <p>Target directory to install</p> | `true` | `~/nuclei-templates` |


## Runs

This action is a `composite` action.

## Usage

```yaml
- uses: ***PROJECT***@***VERSION***
  with:
    version:
    # Download specific version (latest, stable, vX.Y.Z)
    #
    # Required: true
    # Default: stable

    target:
    # Target directory to install
    #
    # Required: true
    # Default: ~/nuclei-templates
```



