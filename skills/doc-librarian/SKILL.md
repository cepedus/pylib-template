---
name: doc-librarian
description: Use whenever documentation is written, updated, reorganized, or audited — new docs pages, README updates, explaining how something works, or a "document this" / "update the docs" request, even if the user doesn't mention Diataxis or a wiki. Classifies content into the right documentation mode, keeps docs/index.md and docs/log.md current, and periodically checks the docs for staleness, contradictions, or orphaned pages. Also use this to decide where a new piece of documentation should live.
---

# Doc Librarian

Documentation has four distinct jobs, and most documentation problems come
from one piece of writing trying to do two of them at once — a reference
page that wanders into tutorial-style hand-holding, or a tutorial padded
with reference-style detail the learner doesn't need yet. This skill
classifies content by job first, then treats `docs/` as a small wiki that
gets maintained, not just appended to. Full framework: [diataxis.fr](https://diataxis.fr).

## 1. Classify before you write

| The content helps someone... | ...who is currently... | It belongs in |
| --- | --- | --- |
| do something, step by step | learning — new to this, needs to succeed on the first try | `docs/tutorials/` |
| do something, step by step | already competent, at work on a real task | `docs/how-to/` |
| look something up | already competent, at work on a real task | `docs/reference/` |
| understand something, the "why" | learning — building a mental model | `docs/explanation/` |

Each `docs/<mode>/README.md` has the local rules for that mode — read it
before adding a page there, it's short.

If a single piece of writing seems to belong in two cells of that table,
split it. That's the most common documentation defect and it's easy to fix
early.

## 2. Treat `docs/` as a wiki, not a pile

`docs/` has three jobs beyond the four content folders:

- **`docs/index.md`** — a catalog: every page, one line each (link +
  one-sentence summary + last-updated date), grouped by mode. Read this
  first when answering a question about the docs or deciding where new
  content goes — before searching page by page.
- **`docs/log.md`** — an append-only history of what changed in the docs
  and why. Every entry starts with `## [YYYY-MM-DD] <ingest|edit|lint> |
  <title>` so it stays greppable: `grep "^## \[" docs/log.md | tail -20`.
- The source code, specs, and PR/commit history itself — the ground truth
  `docs/` is synthesizing. `docs/` describes the system; it doesn't replace
  reading the system when something is unclear.

## 3. Three operations

**Ingest** — new source material lands (a merged feature, a design
decision, a bug postmortem worth remembering). Extract what's durable and
user-facing, classify it (§1), write or update the page, update
`docs/index.md`, append a `docs/log.md` entry. A single change can touch
several pages — that's normal, do all of them in the same pass rather than
leaving the others stale.

**Query** — answer a documentation question by reading `docs/index.md`
first, then the specific page(s) it points to, rather than re-deriving the
answer from source every time. If answering required real synthesis across
multiple pages, that synthesis is worth filing back as an update to an
existing page (or, rarely, a new one) — good answers shouldn't disappear
into chat history.

**Lint** — when asked to check the docs, or periodically on a mature
project, scan for:
- pages nothing links to (orphans)
- claims that no longer match the current code
- a mode-mixing page (see §1)
- a concept mentioned in several places that still has no page of its own
- gaps in `docs/index.md` — pages that exist but aren't cataloged

Report findings as a short list. Don't silently rewrite pages during a lint
pass — surface what's wrong and let the human decide what's worth fixing
now versus later, unless the fix is purely mechanical (a dead link, a
missing index entry).

## 4. Stay small until you need to grow

For most projects, a flat `docs/index.md` is enough to navigate the whole
wiki — there's no need to stand up a search index, embeddings, or an MCP
server until the docs are genuinely too large to read the index and skim.
Add tooling when the index stops being enough, not before.
