## Description

Setup Dotfiles

## Inputs

| name | description | required | default |
| --- | --- | --- | --- |
| `source` | <p>File to source</p> | `true` | `https://github.com/projectdiscovery/actions/raw/refs/heads/dotfiles/.bash_aliases` |


## Runs

This action is a `composite` action.

## Usage

```yaml
- uses: projectdiscovery/actions/setup/dotfiles@v1
  with:
    source:
    # File to source
    #
    # Required: true
    # Default: https://github.com/projectdiscovery/actions/raw/refs/heads/dotfiles/.bash_aliases
```



