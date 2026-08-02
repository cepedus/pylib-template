#!/usr/bin/env bash
# Verifies every per-agent adapter file still points back to AGENTS.md
# instead of drifting into its own copy of the rules.
set -euo pipefail

cd "$(dirname "$0")/.."

MARKER="Canonical source: AGENTS.md"
FILES=(
  "CLAUDE.md"
  "GEMINI.md"
  ".github/copilot-instructions.md"
  ".cursor/rules/agents.mdc"
  ".windsurf/rules/agents.md"
  ".clinerules/agents.md"
  ".kiro/steering/agents.md"
)

fail=0
for f in "${FILES[@]}"; do
  if [ ! -f "$f" ]; then
    echo "MISSING  $f"
    fail=1
    continue
  fi
  if ! grep -q "$MARKER" "$f"; then
    echo "DRIFTED  $f (no longer points back to AGENTS.md — merge its content into AGENTS.md and restore the pointer)"
    fail=1
  else
    echo "OK       $f"
  fi
done

exit $fail
