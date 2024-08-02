## Description

Install Nuclei engine

## Inputs

| name | description | required | default |
| --- | --- | --- | --- |
| `version` | <p>Setup with specific version</p> | `false` | `latest` |


## Outputs

| name | description |
| --- | --- |
| `version` | <p>Installed Nuclei engine version</p> |
| `config_dir` | <p>Nuclei config directory</p> |
| `cache_dir` | <p>Nuclei cache directory</p> |
| `pdcp_dir` | <p>ProjectDiscovery Cloud Platform directory</p> |


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
```



