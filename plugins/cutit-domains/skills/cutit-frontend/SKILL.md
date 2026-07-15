---
name: cutit-frontend
description: Catches frontend-specific token waste — reading compiled/bundled output instead of source, un-filtered devtool/console logs, whole-stylesheet reads to find one rule, full-page DOM dumps to verify a small visual change. Invoke when working on UI components, styles, or a frontend build/dev-server issue.
---

# cutit-frontend

Frontend work tempts wide reads that a narrower one would answer just as
well: the built bundle instead of the source it came from, the whole
console log instead of the one error, the whole stylesheet instead of the
one selector. None of that width helps — the bundler already maps errors
back to source lines, and the rest is boilerplate paid for on every read.

## Protocol

- Grep the component/prop/selector name before reading a component tree or stylesheet; don't open a file whole to find one prop or one rule.
- Never read compiled/bundled output (`dist/`, `.next/`, `build/`) to debug — read the source. Bundler errors already point at the source line.
- Cap browser/dev-server logs to the request, route, or component that errored (filter by tag or timestamp) instead of tailing the full console.
- Verify a UI change with one targeted screenshot of the changed viewport/component, not a full-page capture plus every intermediate state.
- Diff a component or style edit against its prior version when the change is localized, instead of re-reading the whole file to confirm it.
- Treat generated files (lockfiles, sourcemaps, cache dirs) as write-only — don't read them back to "check" a build; check the build's actual output or error instead.

## When not to cut

A layout bug that depends on ancestor CSS cascade, a shared theme token, or global state can't be diagnosed from the one component alone — widen to the actual dependency chain (grep the shared class/token/provider) once a narrow read doesn't explain the symptom, rather than guessing from the local file in isolation.
