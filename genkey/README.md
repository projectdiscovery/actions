## Description

Generate an armored GPG keypair

## Inputs

| name | description | required | default |
| --- | --- | --- | --- |
| `name` | <p>Name for the generated GPG identity. Defaults to the triggering actor login when empty.</p> | `false` | `""` |
| `email` | <p>Email for the generated GPG identity. Defaults to the triggering actor noreply email when empty.</p> | `false` | `""` |
| `expire` | <p>GPG key expiration (for example 0, 30d, 12m, 1y)</p> | `false` | `0` |
| `passphrase` | <p>Passphrase for the secret key. Leave empty to disable protection.</p> | `false` | `""` |
| `public-key-path` | <p>Path where the armored public key should be written. Defaults to <repository>.pub.asc when empty.</p> | `false` | `""` |
| `private-key-path` | <p>Path where the armored private key should be written. Defaults to <repository>.priv.asc when empty.</p> | `false` | `""` |


## Outputs

| name | description |
| --- | --- |
| `public-key-path` | <p>Path to the exported armored public key</p> |
| `private-key-path` | <p>Path to the exported armored private key</p> |


## Runs

This action is a `composite` action.

## Usage

```yaml
- uses: projectdiscovery/actions/genkey@v1
  with:
    name:
    # Name for the generated GPG identity. Defaults to the triggering actor login when empty.
    #
    # Required: false
    # Default: ""

    email:
    # Email for the generated GPG identity. Defaults to the triggering actor noreply email when empty.
    #
    # Required: false
    # Default: ""

    expire:
    # GPG key expiration (for example 0, 30d, 12m, 1y)
    #
    # Required: false
    # Default: 0

    passphrase:
    # Passphrase for the secret key. Leave empty to disable protection.
    #
    # Required: false
    # Default: ""

    public-key-path:
    # Path where the armored public key should be written. Defaults to <repository>.pub.asc when empty.
    #
    # Required: false
    # Default: ""

    private-key-path:
    # Path where the armored private key should be written. Defaults to <repository>.priv.asc when empty.
    #
    # Required: false
    # Default: ""
```



