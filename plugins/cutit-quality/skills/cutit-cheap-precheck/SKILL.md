---
name: cutit-cheap-precheck
description: Catches the habit of launching a full test suite or manual end-to-end verification before running the lint/type-check/smoke-test that would have caught the same bug in seconds. Invoke before any expensive verification pass on a change that hasn't been syntax- or type-checked yet.
---

# cutit-cheap-precheck

Full verification (integration suite, manual click-through, multi-file re-read) burns tokens rediscovering mistakes a linter or type-checker already knows how to name instantly. Running the expensive pass first means every typo or type mismatch gets diagnosed the slow way.

## Protocol

- Run the fastest available check first: linter, type-checker, `--check`/`--dry-run` flag, or a single smoke test — whichever returns in seconds, not minutes.
- Only proceed to the expensive verification pass (full suite, end-to-end run, manual trace) once the cheap pass is clean.
- If the cheap check fails, fix and re-run it before touching the expensive pass at all — don't let a syntax error consume a full test-suite cycle.
- Pick the precheck that actually covers the class of mistake you're likely to make (type errors for typed code, import/syntax check for scripts, a single-case smoke test for logic changes) — a precheck that can't catch the likely bug is wasted motion.
- Chain checks cheapest-to-most-expensive rather than picking one and stopping — lint, then types, then a smoke test, then the full pass.

## When not to cut

If the change is in a class the cheap check can't see (config parsing bugs a linter won't flag, runtime-only behavior, race conditions), go straight to real verification — a green precheck that can't detect the actual risk is false confidence, not a saved step.
