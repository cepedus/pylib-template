---
name: plan-before-build
description: Use before starting any non-trivial coding task — new features, architecture or schema changes, multi-file refactors, or anything with more than one reasonable way to build it. Produces a brief plan and then argues against that plan before code gets written. Trigger this before writing the first line of implementation code for non-trivial work, not after; skip it for small, obvious, single-line fixes.
---

# Plan Before Build

Code written against an unexamined plan tends to encode the first idea
rather than the best one. A short adversarial pass before writing anything
catches this cheaply — much cheaper than catching it in review, or in
production.

## The workflow

1. **Restate the goal in 1–3 sentences.** If it can't be stated that
   briefly, the task may need to be broken up before it can be planned.
2. **Propose the smallest plan that could work.** Pair with
   `minimal-by-default`: what's the least amount of new code, new files, or
   new dependencies that solves this?
3. **Interrogate the plan, adversarially, as if reviewing someone else's
   proposal:**
   - What's the simplest input that would break this?
   - What am I assuming that might not hold (about data shape, ordering,
     concurrency, who calls this, what state the system is in)?
   - Is there a smaller version of this that still satisfies the actual
     request?
   - What would a skeptical senior reviewer flag in this plan before a line
     of code exists?
4. **Revise the plan** based on what step 3 surfaces, or note explicitly
   why a surfaced risk is out of scope for this task.
5. **Then build.**

## How much ceremony

Scale this to the task. A well-understood, single-file change doesn't need
a written plan — do steps 1–3 as an internal check and move on. Reserve a
visible, written plan (shared with the user before implementation starts)
for: new features, anything touching more than a couple of files,
schema/API/data-model changes, or anything where you can see more than one
reasonable approach. If you're not sure which bucket a task is in, do the
lightweight version — the goal is better decisions, not paperwork for its
own sake.

## What this is not

This is not a design-document process and not a substitute for the user's
own judgment. It's a five-minute check that catches the mistakes that are
obvious in hindsight but easy to miss when moving fast. If the
interrogation step doesn't surface anything, that's a fine outcome — say so
and proceed.
