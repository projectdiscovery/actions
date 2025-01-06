## Description

Setup Dotfiles

## Inputs

| name | description | required | default |
| --- | --- | --- | --- |
| `file` | <p>File to source (remote URL)</p> | `true` | `https://github.com/projectdiscovery/actions/raw/refs/heads/dotfiles/.bash_aliases` |


## Runs

This action is a `composite` action.

## Usage

```yaml
- uses: projectdiscovery/actions/setup/dotfiles@v1
  with:
    file:
    # File to source (remote URL)
    #
    # Required: true
    # Default: https://github.com/projectdiscovery/actions/raw/refs/heads/dotfiles/.bash_aliases
```



