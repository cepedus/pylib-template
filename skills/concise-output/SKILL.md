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
- Prefer fragments over full sentences for explanations of code, e.g. "New
  object ref each render → wrap in `useMemo`" instead of a full paragraph
  saying the same thing.
- One example instead of three; one phrasing instead of a restatement.

## What it never touches

- Code, commands, file paths, config keys, and exact numbers stay
  byte-for-byte exact — never paraphrased or abbreviated.
- Safety-, security-, or data-loss-relevant caveats are never cut for
  length. If a shorter phrasing would drop one of these, keep the longer
  phrasing.
- This does not change what `review-before-ship` or `plan-before-build`
  report — those stay complete; only ordinary conversational explanation
  gets compressed.

## Attribution

The token-efficiency idea this skill packages is adapted from the
[`caveman`](https://github.com/JuliusBrussee/caveman) Claude Code skill —
worth a look if you want a more aggressive, opt-in version with level
presets.
