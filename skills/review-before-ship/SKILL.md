---
name: review-before-ship
description: Use after producing a non-trivial code diff, and before telling the user a task is done — runs one adversarial self-review pass as a skeptical senior engineer looking at someone else's pull request. Checks correctness, security, failure modes, and unnecessary complexity. Trigger this after finishing implementation work, especially anything touching authentication, payments, user data, external input, or concurrency, before declaring the task complete.
---

# Review Before Ship

The last five minutes before code ships are the cheapest place to catch a
problem. This is a single adversarial read of your own diff, done as if it
were someone else's pull request landing on your desk.

## What to check

Go through the diff (not the plan — the actual code) against each of these.
Skip categories that plainly don't apply to the change (a copy edit to a
docs page doesn't need a concurrency check) — don't pad the review with
irrelevant boxes ticked.

- **Correctness** — does the code actually do what was asked, for the cases
  the user described and the obvious adjacent ones?
- **Security** — is every trust boundary (user input, network response,
  file read, query param, third-party payload) validated rather than
  trusted? Any secrets or credentials that shouldn't be in this diff? Any
  injection surface (SQL, shell, template, path traversal)?
- **Failure modes** — what happens on bad input, a network timeout, a
  missing file, two callers at once? Does a failure fail loud, or does it
  fail silent and leave bad state behind?
- **Data safety** — does anything here delete, overwrite, or migrate data?
  Is that path as careful as it needs to be?
- **Complexity** — is there anything here a `minimal-by-default` pass would
  cut? A diff review is a second chance to catch scope creep the plan
  didn't.
- **Test coverage on the risky part** — not full coverage, but: is the part
  most likely to break actually exercised?

## Reporting

Say what you found, plainly, including things you'd normally be tempted to
gloss over — this review is only useful if it's honest. For each finding:

- **Cheap to fix** → fix it before calling the task done.
- **A real judgment call** (a tradeoff, a scope question, something that
  needs product input) → flag it explicitly to the user rather than
  silently picking a side.

Finding nothing is a legitimate outcome for a small, well-scoped change —
don't invent issues to justify the pass.
