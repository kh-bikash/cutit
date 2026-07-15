---
name: cutit-dependency-ordering
description: Catches plans that run an expensive step before a cheap check that could have invalidated the whole plan — wasting the expensive step's tokens on a premise that was never going to hold. Invoke when ordering independent steps in a plan, before executing any of them.
---

# cutit-dependency-ordering

If a plan has a $0.01 sanity check and a $1 operation, and the check would
have caught a bad premise, running the $1 operation first and the check
after means paying for the failure twice. Ordering by cost, not just by
narrative convenience, lets a bad plan die cheaply.

## Protocol

- Before executing, scan the plan for any step whose failure would make
  later steps pointless — a file-exists check, a test that must currently
  pass, a config value that must be set.
- Move those gating checks to the front, ahead of steps that are expensive
  (large reads, sub-agent spawns, builds, writes) regardless of the order
  they were first listed in.
- When two steps are independent but one is far cheaper, run the cheap one
  first even if it's not strictly a "check" — a fast grep that could show
  the task is already done is effectively a gate.
- Don't reorder steps that have a real correctness dependency (B needs A's
  output) just to chase cost — ordering by cost only applies among steps
  that don't depend on each other.

## When not to cut

If the cheap check has a real chance of false negatives (it can pass even
when the expensive step would fail), don't treat it as a substitute gate —
run it as a first pass, but still expect to pay for the expensive step's
own verification, don't skip that on the cheap check's say-so.
