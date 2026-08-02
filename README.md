# pylib-template

[![Copier](https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/copier-org/copier/master/img/badge/badge-black.json)](https://github.com/copier-org/copier)

**A modern [Copier](https://copier.readthedocs.io/) template designed to quickly bootstrap Python library projects with best practices, tooling, and automation built-in.**

```bash
copier copy --trust https://github.com/cepedus/pylib-template /path/to/new/project
```

## Features

The template provides:

- **Python Version Support**: Choose from Python 3.10, 3.11, 3.12, 3.13, or 3.14
- **Input Validation**: Ensures project names and slugs follow Python naming conventions
- **Pre-configured Automation**: Post-generation tasks including:
  - Git initialization with `main` branch
  - Dependency management via [`uv`](https://docs.astral.sh/uv/)
  - Code formatting with [`ruff`](https://docs.astral.sh/ruff/)
  - Type checking with [`pyrefly`](https://pyrefly.org/en/docs/)
  - Pre-commit hooks via [`prek`](https://prek.j178.dev/)
  - Rather strict lint and typing checks

## Configuration Options

When generating a new project, you'll be prompted for:

### `project_name` (required)
- **Format**: Lowercase letters, digits, and underscores
- **Constraints**: Must start and end with a letter or digit
- **Example**: `my_library`, `awesome_tool`

### `project_slug` (auto-generated, customizable)
- **Format**: Lowercase letters, digits, and hyphens
- **Default**: Project name with underscores replaced by hyphens
- **Constraints**: Must start and end with a letter or digit
- **Example**: `my-library`, `awesome-tool`

### `python_version`
- **Choices**: 3.10, 3.11, 3.12 (default), 3.13, 3.14
- **Default**: `3.12`

### `main_branch_name`
- **Choices**: Any git-valid branch name
- **Default**: `main`

## Usage

⚠️ You need to specify `--trust` because of the automation tasks. These are defined on the [`copier.yml`](copier.yml) file

To create a new project from this template:

```bash
copier copy --trust https://github.com/cepedus/pylib-template /path/to/new/project
```

Without the `--trust` option, the following actions will not be performed:
- Initialize a `git` repository
- Create a virtual environment
- Install pre-commit hooks
- Run hooks once

# Agentic development support

A drop-in `AGENTS.md` + skills + docs structure for working with AI coding
agents, built by combining four complementary ideas:

- **[Diátaxis](https://diataxis.fr)** — a four-mode framework for organizing
  documentation (tutorials / how-to / reference / explanation).
- **[Karpathy's LLM-wiki gist](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f)**
  — treating a docs folder as a small, LLM-maintained wiki with a raw-source
  layer, a synthesized layer, and a schema file governing both, kept
  current with ingest/query/lint operations.
- **[ponytail](https://github.com/dietrichgebert/ponytail)** — a YAGNI-first
  ladder for how much code a task actually needs, with explicit carve-outs
  for security, data safety, and accessibility.
- **[caveman](https://github.com/juliusbrussee/caveman)** — the idea that an
  agent's *prose* is a cost separate from its *substance*, packaged here as
  an opt-in style toggle.

None of these are copied verbatim — each is adapted into a plain-markdown
convention that works with any agent that reads `AGENTS.md`-style files
(Claude Code, Cursor, Codex, Copilot, Gemini CLI, Windsurf, Cline, Kiro...).

## What's in here

```
AGENTS.md                      the canonical rulebook — start here
CLAUDE.md, GEMINI.md, ...      thin per-agent pointers back to AGENTS.md
skills/                        guardrail skills (SKILL.md format)
  minimal-by-default/            build the least that works (ponytail)
  plan-before-build/             adversarial plan review before coding
  review-before-ship/            adversarial diff review before shipping
  doc-librarian/                 Diataxis classification + wiki upkeep
  concise-output/                opt-in terse-prose style (caveman)
docs/                          the project's own documentation wiki
  index.md, log.md               catalog + append-only change history
  tutorials/, how-to/, reference/, explanation/   Diataxis's four modes
scripts/
  check-agent-sync.sh            verify no adapter file has drifted
```

## Design notes

- **Four of the five skills are on by default; one (`concise-output`) is
  opt-in.** Guardrails around correctness and simplicity shouldn't require
  configuration; a terser voice is a preference, not a guardrail, so it
  stays off unless asked for.
- **The per-agent files are pointers, not copies.** ponytail's own repo
  ships a rule-copy checker script because it duplicates rule text into six
  separate rule files and has to keep them aligned by hand. This template
  avoids that problem at the source: every adapter file (`CLAUDE.md`,
  `.cursor/rules/agents.mdc`, etc.) contains nothing but a pointer back to
  `AGENTS.md`, so there's only ever one copy of the actual rules to edit.
  `scripts/check-agent-sync.sh` just confirms the pointer is still there.
- **`AGENTS.md` stays short on purpose.** It's loaded every session by
  every agent that reads it. Depth lives in `skills/`, which only loads
  when a skill actually triggers — the same progressive-disclosure
  principle Diataxis and the wiki pattern both rely on.
- **This won't outgrow a small project and won't undersell a large one.**
  `doc-librarian` explicitly says to stay with a flat `docs/index.md` until
  it's genuinely not enough — no search infra, no vector store, no MCP
  server bundled here. Add those later if you need them.

## Keeping AGENTS.md alive

Treat `AGENTS.md` the way the wiki pattern treats its schema file: it
should change as the project teaches you things. If the same mistake gets
corrected twice, that's a signal to write the rule into `AGENTS.md` instead
of re-explaining it every session. Review changes to it with a bit more
scrutiny than a docs page — every future agent session reads it.
