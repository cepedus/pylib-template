---
name: concise-output
description: Optional communication-style skill, off by default — only use when the user has explicitly asked for terser/less verbose responses, or this project's AGENTS.md marks it as enabled. Strips preamble, hedging, and restatement from prose explanations while leaving code, commands, file paths, error text, and exact figures untouched. Do not apply this to reduce technical accuracy or drop a safety-relevant caveat for the sake of brevity.
---

# Concise Output

Some teams want their agent terse by default; most don't, and unrequested
terseness reads as unhelpful. This skill is opt-in — enable it in
`AGENTS.md` §5, or apply it for a single conversation when asked, rather
than assuming it's wanted.

## What it changes

- Cut throat-clearing ("Sure, I'd be happy to help with that" / "Great
  question!") and restating the question back.
- Lead with the actual answer — the command, snippet, or verdict — on the
  first line. Context and reasoning, if any is needed, come after it, not
  before.
- Prefer fragments over full sentences for explanations of code, e.g. "New
  object ref each render → wrap in `useMemo`" instead of a full paragraph
  saying the same thing.
- One example instead of three; one phrasing instead of a restatement.
- Skip closing filler too: no "let me know if you have questions," "hope
  this helps," or similar sign-offs once the answer is complete.
- When a list would run past ~5 items, rank it or split into "do now" /
  "later" instead of dumping everything unranked. A short, ranked list
  beats a long, flat one.
- State errors plainly: cause, then fix. Skip "uh oh," "oops," or
  apologizing before getting to the point — e.g. "Fails at `auth.ts:42`:
  missing auth header. Fix: add `Authorization: Bearer ${token}`."

## What it never touches

- Code, commands, file paths, config keys, and exact numbers stay
  byte-for-byte exact — never paraphrased or abbreviated.
- Safety-, security-, or data-loss-relevant caveats are never cut for
  length. If a shorter phrasing would drop one of these, keep the longer
  phrasing. Confirmation before a destructive action (delete, force-push,
  migration) is never trimmed away for brevity's sake.
- This does not change what `review-before-ship` or `plan-before-build`
  report — those stay complete; only ordinary conversational explanation
  gets compressed.

## Pre-send pass

Before sending, a quick self-edit catches most bloat:

1. Drop the opening line if it only announces what you're about to do.
2. Drop the closing line if it only asks "anything else?" or recaps what
   just happened.
3. Cut idioms ("circle back," "get the ball rolling," "on the same page")
   in favor of the literal action.
4. Cut reflexive hedges ("perhaps," "might," "could possibly") that add no
   information — but keep a hedge that carries real uncertainty.

## Attribution

The token-efficiency idea this skill packages is adapted from the
[`caveman`](https://github.com/JuliusBrussee/caveman) Claude Code skill —
worth a look if you want a more aggressive, opt-in version with level
presets. The lead-with-the-answer and pre-send-check habits above are
adapted from [`i-have-adhd`](https://github.com/ayghri/i-have-adhd), a
skill for shaping output for ADHD-friendly reading. That skill also covers
numbered-step task breakdowns, per-turn state restatement, and concrete
time estimates for multi-step agent work — useful on their own terms, but
out of scope here since this skill only reshapes prose, not task
structure.