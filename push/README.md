## Description

Push the commits a job made to its branch

## Inputs

| name | description | required | default |
| --- | --- | --- | --- |
| `ref` | <p>Branch to push to. Defaults to the branch the job checked out: <code>github.head_ref</code> for a <code>pull_request</code> event, otherwise <code>github.ref_name</code> when the run is on a branch. A run on a tag must set it. A <code>pull_request</code> job must check out <code>github.head_ref</code>, because actions/checkout checks out the merge commit by default. For a pull request from a fork, <code>github.head_ref</code> names the fork's branch, not one on origin</p> | `false` | `""` |
| `token` | <p>Token with <code>contents: write</code> permission, used only for the git commands of this action, so the checkout can use <code>persist-credentials: false</code>. Pass a secret or <code>github.token</code>, which the runner masks in the log. When empty, the action uses the credentials the checkout left in the git config</p> | `false` | `""` |
| `rebase` | <p>Run <code>git pull --rebase</code> before pushing, which refuses to run with uncommitted changes. The rebase is skipped when the branch is not on the remote yet. With <code>false</code>, the push is rejected when the branch moved during the run, even without new commits</p> | `false` | `true` |
| `dry-run` | <p>Pass <code>--dry-run</code> to <code>git push</code>, which does everything except send the update. The rebase still runs</p> | `false` | `false` |


## Runs

This action is a `composite` action.

## Usage

```yaml
- uses: projectdiscovery/actions/push@v1
  with:
    ref:
    # Branch to push to. Defaults to the branch the job checked out: `github.head_ref` for a `pull_request` event, otherwise `github.ref_name` when the run is on a branch. A run on a tag must set it. A `pull_request` job must check out `github.head_ref`, because actions/checkout checks out the merge commit by default. For a pull request from a fork, `github.head_ref` names the fork's branch, not one on origin
    #
    # Required: false
    # Default: ""

    token:
    # Token with `contents: write` permission, used only for the git commands of this action, so the checkout can use `persist-credentials: false`. Pass a secret or `github.token`, which the runner masks in the log. When empty, the action uses the credentials the checkout left in the git config
    #
    # Required: false
    # Default: ""

    rebase:
    # Run `git pull --rebase` before pushing, which refuses to run with uncommitted changes. The rebase is skipped when the branch is not on the remote yet. With `false`, the push is rejected when the branch moved during the run, even without new commits
    #
    # Required: false
    # Default: true

    dry-run:
    # Pass `--dry-run` to `git push`, which does everything except send the update. The rebase still runs
    #
    # Required: false
    # Default: false
```



