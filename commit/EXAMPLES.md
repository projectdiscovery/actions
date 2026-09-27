# Commit and push

Set `push: true` to run `git push` after a new commit is created. The push uses
the checked-out branch's Git remote and upstream configuration. Check out a
branch (rather than a detached commit) and give the workflow permission to push:

```yaml
permissions:
  contents: write

jobs:
  update-generated-files:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v7
        with:
          ref: ${{ github.ref_name }}
      - name: Configure commit author
        run: |
          git config user.name 'github-actions[bot]'
          git config user.email '41898282+github-actions[bot]@users.noreply.github.com'
      # Generate or edit the files to commit here.
      - uses: projectdiscovery/actions/commit@v1
        with:
          files: generated.txt
          message: 'chore: update generated files'
          push: true
```

This example is intended for branch workflows such as `push` or
`workflow_dispatch`. If no new commit is created, the action does not push.
A rejected push fails the action and leaves the local commit available for
inspection. Existing workflows continue to commit locally unless they opt in.
