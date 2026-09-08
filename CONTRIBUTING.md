# Contributing

Thanks for your interest in improving this template. This file covers the
practical bits of working on the repo. For how AI coding agents should
behave in this project, read [`AGENTS.md`](./AGENTS.md) — that file is
the canonical rulebook.

## Local development

The project uses [`uv`](https://docs.astral.sh/uv/) for everything.

```bash
uv sync
```

Run the full CI suite locally before opening a PR:

```bash
make ci
```

That runs `ruff check`, `ruff format --check`, `pyrefly check`, and
`pytest`. Pre-commit hooks are installed by `prek` (already configured
via `copier.yml` after the initial template generation); if they're not
active in your checkout, run `uv run prek install`.

## Updating the template from upstream

This repo is itself a [Copier](https://copier.readthedocs.io/) template.
To pull in changes from the upstream template:

```bash
copier update --trust
```

The `--trust` flag is required because the template's `_tasks` run
`uv sync`, `prek install`, and the hook suite on update.

## Making a release

Releases are driven by a single keyword on a commit message and the
contents of the `VERSION` file. There is no manual tagging step.

### Flow

```
push to main
  └─► "Test template" workflow
        └─► (on success) "Tag and release" workflow
              ├─ check: head commit message starts with "[RELEASE]"
              ├─ read VERSION file → TAG
              ├─ fail if refs/tags/${TAG} already exists
              └─ gh release create "${TAG}"
```

### Steps

1. Bump the version in [`VERSION`](./VERSION) to the new tag (e.g.
   `0.2.1` → `0.3.0`). Plain text, no `v` prefix — the workflow uses
   the file contents verbatim.
2. Open a PR titled `[RELEASE] <note>` (e.g. `[RELEASE] 0.3.0`). The
   repo is configured to **squash-merge**, so the merge commit's
   message becomes the PR title — the `[RELEASE]` prefix on that
   commit is what triggers the release job. The text after the prefix
   doesn't matter; the prefix does.
3. Merge the PR. If the "Test template" workflow fails, the release
   job is skipped — fix the failure and push again. The release
   workflow will not run on a red CI.
4. The release appears as a GitHub release tagged with the contents of
   `VERSION`, with notes `Published by GitHub Actions workflow.`

### Rules of the mechanism

- **Don't reuse a version.** The release job fails (with a clear error
  message) if the tag from `VERSION` already exists. Bump it.
- **Don't add `v` to `VERSION`.** The release tag is whatever the file
  says; a `v` prefix means your git tags and your releases disagree.
- **The `[RELEASE]` prefix must land on the merge commit on `main`.**
  The workflow inspects `github.event.workflow_run.head_commit.message`,
  which is the squash commit on `main`. The repo squash-merges with
  the PR title as the commit message, so title the PR with `[RELEASE]`
  (or prepend it in the squash-merge dialog). If you merge with a
  method that drops the title — e.g. a fast-forward merge or a PR
  titled without `[RELEASE]` — the release job won't trigger.
- **`[RELEASE]`-titled PRs must bump `VERSION`.** The
  `validate-release` workflow runs on every PR title edit
  (`opened`/`edited`/`reopened`/`synchronize`) and fails the check if
  `VERSION` isn't in the diff between the PR's base and head. It's
  fast and cheap — if you don't want a release, drop the `[RELEASE]`
  prefix from the title.
- **Releases are tied to green CI.** A failing "Test template" run
  silently skips the release. There is no manual override in the
  workflow — fix CI and re-push.
