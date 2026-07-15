---
name: cutit-targeted-verification
description: Catches the reflex of re-running the whole test suite or re-reading every consumer of a module after a change whose blast radius is already known and small. Invoke right after a change when you can name exactly which files/functions/tests it could plausibly affect.
---

# cutit-targeted-verification

When a change is confined to one function with known callers, re-verifying the entire system anyway pays for coverage the change couldn't have broken — every unrelated test re-run and unrelated file re-read is pure overhead the diff didn't earn.

## Protocol

- Before verifying, name the blast radius explicitly: which functions call the changed code, which tests exercise those call paths, which files import the changed module.
- Run only the tests that cover the named blast radius, not the full suite — use test-file filters or `-k`/pattern flags instead of a bare test-runner invocation.
- If the change is purely internal to a function (same signature, same contract), verify with the function's own unit tests and skip re-checking its callers entirely.
- Re-derive the blast radius with a grep for the changed symbol's usages before trusting your own memory of who calls it — a guessed blast radius that's too narrow is the actual risk here, not the token cost of checking.
- Widen the verification only when the grep turns up more callers than expected — let the evidence expand scope, don't pre-emptively verify everything "just in case."

## When not to cut

If the change touches a shared utility, a public API, or anything whose callers you can't enumerate with confidence (dynamic dispatch, reflection, string-based lookups), the blast radius isn't actually known — fall back to the full verification pass instead of guessing a boundary.
