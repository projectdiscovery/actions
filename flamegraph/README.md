## Description

Upload a CPU profile to get a publicly sharable link

## Inputs

| name | description | required | default |
| --- | --- | --- | --- |
| `profile` | <p>Path to profile file</p> | `true` | `""` |
| `name` | <p>Profile name</p> | `false` | `""` |


## Outputs

| name | description |
| --- | --- |
| `key` | <p>Flamegraph key</p> |
| `url` | <p>Flamegraph public URL</p> |
| `message` | <p>Error message</p> |


## Runs

This action is a `composite` action.

## Usage

```yaml
- uses: projectdiscovery/actions/flamegraph@v1
  with:
    profile:
    # Path to profile file
    #
    # Required: true
    # Default: ""

    name:
    # Profile name
    #
    # Required: false
    # Default: ""
```



