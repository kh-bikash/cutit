---
name: cutit-root-cause-first-retry
description: Catches the reflex of re-running a failed command or test unchanged and hoping for a different outcome, instead of reading the first failure closely enough to name why it happened. Invoke the moment a command fails and before issuing any retry.
---

# cutit-root-cause-first-retry

A blind retry pays the full cost of the command again — same build, same test run, same API call — and if the cause wasn't transient, it fails again for the same reason, doubling spend for zero new information. Diagnosing from the first failure is nearly free by comparison; it's already sitting in context.

## Protocol

- Before retrying anything, read the actual failure: the error type, the line it points to, the last few lines of a stack trace — not just "it failed."
- Classify it: transient (network blip, lock contention, flaky timing) vs. deterministic (wrong argument, missing dependency, logic bug). Only transient failures justify a same-command retry.
- For a deterministic failure, form a one-sentence hypothesis of the cause before changing anything, and make the retry test that hypothesis (a fixed argument, an added flag) rather than repeating the exact same call.
- If the failure message is ambiguous, spend one cheap lookup (grep the error string in the codebase, check a config value) before retrying — that lookup is cheaper than a second failed run.
- Never issue the identical command twice in a row without a stated reason (e.g., "retrying because this class of error is known-flaky") — an unexplained repeat is a signal you're guessing.

## When not to cut

If the system is a known flaky integration (rate limits, eventually-consistent infra) where transient failures dominate and diagnosis time exceeds the retry's cost, a quick bounded retry first is fine — but still read the failure once so you can tell transient from deterministic on the next occurrence.
