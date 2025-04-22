## Description

Run GoReleaser

## Inputs

| name | description | required | default |
| --- | --- | --- | --- |
| `release` | <p>Run without snapshot</p> | `false` | `false` |
| `workdir` | <p>Working directory</p> | `false` | `.` |
| `args` | <p>Run with arguments</p> | `false` | `""` |


## Runs

This action is a `composite` action.

## Usage

```yaml
- uses: projectdiscovery/actions/goreleaser@v1
  with:
    release:
    # Run without snapshot
    #
    # Required: false
    # Default: false

    workdir:
    # Working directory
    #
    # Required: false
    # Default: .

    args:
    # Run with arguments
    #
    # Required: false
    # Default: ""
```



