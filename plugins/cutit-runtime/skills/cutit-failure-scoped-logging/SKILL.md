---
name: cutit-failure-scoped-logging
description: Catches capturing an entire test/CI run's logs when only the failing case's slice is needed to diagnose it. Invoke when pulling logs after a run that had both passing and failing parts.
---

# cutit-failure-scoped-logging

A full run's log includes setup output, every passing test's chatter, and teardown noise alongside the one failure that matters. Pulling all of it into context to find one red line spends tokens reading green ones.

## Protocol

- Filter for the failing case by name/ID first (test runner's own filter flag, or a grep for FAIL/ERROR) instead of dumping the full run output.
- When the runner supports it, re-run just the failing case in isolation with verbose output, rather than re-reading the full suite's log a second time.
- Include only enough surrounding context to place the failure (its test name, the setup immediately before it) — skip unrelated passing-test output even if it's interleaved in the same log.
- If several failures share one root cause (one broken fixture, one bad import), capture one representative failure's full detail and just list the others' names/counts.
- When reporting, quote the failing slice, not the run summary line count plus everything else — the user needs the failure, not proof the log exists.

## When not to cut

If the failure might be caused by cross-test pollution or ordering (state leaking between tests, a shared fixture mutated earlier in the run), keep enough of the surrounding run — not just the failing case — to see what ran before it, since isolating too aggressively can hide exactly the interaction you need to see.
