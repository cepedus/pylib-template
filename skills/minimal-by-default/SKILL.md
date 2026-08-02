---
name: minimal-by-default
description: Use whenever writing, planning, or reviewing implementation code — new features, bug fixes, refactors, scaffolding, or dependency choices. Enforces building the least amount of code, abstraction, or dependency that solves the actual problem, before reaching for something bigger. Trigger this any time the user asks to add, build, implement, wire up, or set up something in code, even if they don't mention minimalism, YAGNI, or simplicity explicitly.
---

# Minimal by Default

Every line of code, every dependency, and every abstraction is something a
human or agent has to read, maintain, and reason about later. The
unnecessary ones are pure liability: extra surface area for bugs, extra
things to keep in sync with the rest of the system, extra layers a future
change has to route around. Before writing anything, check whether it needs
to exist at all.

## The ladder

Work down this list. Stop at the first rung that solves the problem — don't
skip ahead to something bigger because it feels more "proper" or more
impressive.

1. **Does this need to exist?** If the feature, abstraction, or file isn't
   actually required by the current request, don't add it. Speculative
   generality ("we might need this later") is a cost paid today for a
   benefit that may never arrive.
2. **Does the standard library already do this?** Check before reaching for
   a package.
3. **Does the platform already do this?** Browsers, OS, framework, and
   language runtimes cover more than people remember — a native
   `<input type="date">`, a built-in hash function, a database constraint,
   before a custom implementation.
4. **Is there already a dependency in this project that does this?** Don't
   add a second library for something an existing one already covers.
5. **Can this be one line?** If a helper function would be a single
   expression, ask whether the function is pulling its weight.
6. **Only now: write the minimum that actually works.** Not the general
   version, not the configurable version — the version that solves the
   request in front of you.

## What is never on this ladder

Being minimal is about not building things nobody asked for — it is not
permission to cut corners on things that were asked for, implicitly or
explicitly. Never simplify away:

- **Trust-boundary validation.** Anything crossing from outside the system —
  user input, network responses, file contents, query params, environment
  variables from an untrusted source — gets validated, not assumed.
- **Data-loss handling.** Destructive or irreversible operations (deletes,
  overwrites, migrations) get the careful path, not the fast one.
- **Security.** AuthN/authZ, secret handling, injection surfaces.
- **Accessibility**, for anything user-facing.
- **Correctness under failure.** Error paths, partial failures, and
  concurrent access get handled — a shortcut here doesn't remove
  complexity, it just hides it until production.

If in doubt about whether something falls into this list, treat it like it
does.

## Marking shortcuts

When a real corner is cut on purpose — deferring a feature, hardcoding a
value that should eventually be configurable, skipping a case that's out of
scope for now — leave it visible instead of silent:

```
// TODO(minimal): hardcoded to the single default currency; add a
// lookup table if/when multi-currency support is actually needed.
```

This makes every shortcut `grep`-able (`grep -rn "TODO(minimal)"`) and gives
the next person — human or agent — the upgrade path instead of a surprise.

## A note on proportionality

This is a default, not a ceremony. For a one-line fix, just make the fix.
The ladder matters most at decision points: a new file, a new dependency, a
new abstraction, a new layer of indirection. Pair this with the
`plan-before-build` skill for anything non-trivial — the ladder is easier to
apply when the plan is stated first.
