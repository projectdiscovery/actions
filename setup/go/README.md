## Description

Run actions/setup-go

## Inputs

| name | description | required | default |
| --- | --- | --- | --- |
| `go-version` | <p>The Go version to download (if necessary) and use. Supports semver spec and ranges. Be sure to enclose this option in single quotation marks.</p> | `false` | `""` |
| `go-version-file` | <p>Path to the go.mod, go.work, .go-version, or .tool-versions file.</p> | `false` | `""` |
| `check-latest` | <p>Set this option to true if you want the action to always check for the latest available version that satisfies the version spec</p> | `false` | `true` |
| `token` | <p>Used to pull Go distributions from go-versions. Since there's a default, this is typically not supplied by the user. When running this action on github.com, the default value is sufficient. When running on GHES, you can pass a personal access token for github.com if you are experiencing rate limiting.</p> | `false` | `${{ github.server_url == 'https://github.com' && github.token || '' }}` |
| `cache` | <p>Used to specify whether caching is needed. Set to true, if you'd like to enable caching.</p> | `false` | `true` |
| `cache-dependency-path` | <p>Used to specify the path to a dependency file (e.g., go.mod, go.sum)</p> | `false` | `**/go.mod` |
| `architecture` | <p>Target architecture for Go to use. Examples: x86, x64. Will use system architecture by default.</p> | `false` | `""` |
| `go-download-base-url` | <p>Custom base URL for downloading Go distributions. Use this to download Go from a mirror or custom source. Defaults to "https://go.dev/dl". Can also be set via the GO<em>DOWNLOAD</em>BASE_URL environment variable. The input takes precedence over the environment variable.</p> | `false` | `""` |


## Runs

This action is a `composite` action.

## Usage

```yaml
- uses: projectdiscovery/actions/setup/go@v1
  with:
    go-version:
    # The Go version to download (if necessary) and use. Supports semver spec and ranges. Be sure to enclose this option in single quotation marks.
    #
    # Required: false
    # Default: ""

    go-version-file:
    # Path to the go.mod, go.work, .go-version, or .tool-versions file.
    #
    # Required: false
    # Default: ""

    check-latest:
    # Set this option to true if you want the action to always check for the latest available version that satisfies the version spec
    #
    # Required: false
    # Default: true

    token:
    # Used to pull Go distributions from go-versions. Since there's a default, this is typically not supplied by the user. When running this action on github.com, the default value is sufficient. When running on GHES, you can pass a personal access token for github.com if you are experiencing rate limiting.
    #
    # Required: false
    # Default: ${{ github.server_url == 'https://github.com' && github.token || '' }}

    cache:
    # Used to specify whether caching is needed. Set to true, if you'd like to enable caching.
    #
    # Required: false
    # Default: true

    cache-dependency-path:
    # Used to specify the path to a dependency file (e.g., go.mod, go.sum)
    #
    # Required: false
    # Default: **/go.mod

    architecture:
    # Target architecture for Go to use. Examples: x86, x64. Will use system architecture by default.
    #
    # Required: false
    # Default: ""

    go-download-base-url:
    # Custom base URL for downloading Go distributions. Use this to download Go from a mirror or custom source. Defaults to "https://go.dev/dl". Can also be set via the GO_DOWNLOAD_BASE_URL environment variable. The input takes precedence over the environment variable.
    #
    # Required: false
    # Default: ""
```



