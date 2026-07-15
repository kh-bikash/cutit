---
name: cutit-error-triage-budget
description: Catches pasting an entire stack trace, build log, or test-runner dump into context when only the last few frames or the first failing assertion are relevant. Invoke whenever a failing command's raw output is longer than a screen and hasn't been triaged yet.
---

# cutit-error-triage-budget

Compilers, test runners, and CI logs love to repeat themselves — the same error surfaces through five layers of wrapper stack frames, or a single bad import cascades into forty downstream failures. Pulling all of it into context spends tokens on repetition instead of the one line that actually names the bug.

## Protocol

- Cap the first read of error output: grep for the actual exception type/message, the first failing test, or the last frame pointing into your own code, rather than reading the full dump top to bottom.
- For a wall of near-identical errors (cascading type errors, repeated import failures), read the first occurrence in full and treat the rest as count, not content — "37 more of the same" is enough.
- Pull in surrounding source only for the frame(s) that are actually yours — skip stack frames inside library/vendor/runtime code unless the error explicitly implicates a call you made into them.
- If the capped read doesn't reveal the cause, widen deliberately (more lines, more frames) rather than defaulting to the full dump every time — widen once, purposefully, not preemptively.
- Summarize triaged output in your own words when reporting back instead of re-pasting the raw log the user can already see in their terminal.

## When not to cut

If the failure is non-repeating and its ordering matters (an interleaved async trace, a log where an earlier line changes the meaning of a later one), read the whole thing — truncating a trace whose frames aren't redundant risks missing the actual cause.
