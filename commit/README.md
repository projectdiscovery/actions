## Description

Run git-commit

## Inputs

| name | description | required | default |
| --- | --- | --- | --- |
| `files` | <p>Files to commit (newline-separated)</p> | `true` | `.` |
| `message` | <p>Commit message</p> | `true` | `""` |
| `gpg-sign` | <p>Sign the commit. <code>true</code> signs with the key git picks by default (<code>user.signingKey</code> when it is set), <code>false</code> skips signing even when <code>commit.gpgSign</code> is set, and any other value is the key ID, or for SSH the key path. The key must already be loaded into git or gpg, and <code>gpg.format</code> selects the signature type. If not provided, git config decides.</p> | `false` | `""` |


## Runs

This action is a `composite` action.

## Usage

```yaml
- uses: projectdiscovery/actions/commit@v1
  with:
    files:
    # Files to commit (newline-separated)
    #
    # Required: true
    # Default: .

    message:
    # Commit message
    #
    # Required: true
    # Default: ""

    gpg-sign:
    # Sign the commit. `true` signs with the key git picks by default (`user.signingKey` when it is set), `false` skips signing even when `commit.gpgSign` is set, and any other value is the key ID, or for SSH the key path. The key must already be loaded into git or gpg, and `gpg.format` selects the signature type. If not provided, git config decides.
    #
    # Required: false
    # Default: ""
```



