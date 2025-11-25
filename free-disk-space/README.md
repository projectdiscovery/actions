## Description

Free up disk space on Linux runners by removing unnecessary runtimes and packages

## Inputs

| name | description | required | default |
| --- | --- | --- | --- |
| `android` | <p>Remove Android runtime</p> | `false` | `true` |
| `dotnet` | <p>Remove .NET runtime</p> | `false` | `true` |
| `haskell` | <p>Remove Haskell runtime</p> | `false` | `true` |
| `llvm` | <p>Remove LLVM toolchain</p> | `false` | `true` |
| `php` | <p>Remove PHP runtime</p> | `false` | `true` |
| `mongodb` | <p>Remove MongoDB runtime</p> | `false` | `true` |
| `mysql` | <p>Remove MySQL runtime</p> | `false` | `true` |
| `misc-packages` | <p>Remove miscellaneous packages (azure-cli google-cloud-sdk google-chrome-stable firefox powershell mono-devel libgl1-mesa-dri)</p> | `false` | `true` |
| `docker-images` | <p>Remove Docker images</p> | `false` | `true` |
| `tools-cache` | <p>Remove image tool cache</p> | `false` | `false` |
| `swap-storage` | <p>Remove swap storage</p> | `false` | `true` |


## Runs

This action is a `composite` action.

## Usage

```yaml
- uses: projectdiscovery/actions/free-disk-space@v1
  with:
    android:
    # Remove Android runtime
    #
    # Required: false
    # Default: true

    dotnet:
    # Remove .NET runtime
    #
    # Required: false
    # Default: true

    haskell:
    # Remove Haskell runtime
    #
    # Required: false
    # Default: true

    llvm:
    # Remove LLVM toolchain
    #
    # Required: false
    # Default: true

    php:
    # Remove PHP runtime
    #
    # Required: false
    # Default: true

    mongodb:
    # Remove MongoDB runtime
    #
    # Required: false
    # Default: true

    mysql:
    # Remove MySQL runtime
    #
    # Required: false
    # Default: true

    misc-packages:
    # Remove miscellaneous packages (azure-cli google-cloud-sdk google-chrome-stable firefox powershell mono-devel libgl1-mesa-dri)
    #
    # Required: false
    # Default: true

    docker-images:
    # Remove Docker images
    #
    # Required: false
    # Default: true

    tools-cache:
    # Remove image tool cache
    #
    # Required: false
    # Default: false

    swap-storage:
    # Remove swap storage
    #
    # Required: false
    # Default: true
```



