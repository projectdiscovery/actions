## Description

Generate Nuclei Templates Checksum

## Inputs

| name | description | required | default |
| --- | --- | --- | --- |
| `version` | <p>Setup with specific version</p> | `false` | `latest` |
| `templates-directory` | <p>Specify Nuclei templates directory</p> | `false` | `/home/runner/work/nuclei-templates/nuclei-templates` |
| `checksum-file` | <p>Specify checksum file output</p> | `true` | `""` |


## Runs

This action is a `composite` action.

## Usage

```yaml
- uses: ***PROJECT***@***VERSION***
  with:
    version:
    # Setup with specific version
    #
    # Required: false
    # Default: latest

    templates-directory:
    # Specify Nuclei templates directory
    #
    # Required: false
    # Default: /home/runner/work/nuclei-templates/nuclei-templates

    checksum-file:
    # Specify checksum file output
    #
    # Required: true
    # Default: ""
```


