---
name: cutit-few-shot-trimming
description: Catches padding a prompt with more or longer few-shot examples than the task needs to hit target accuracy — invoke when assembling or reviewing a few-shot prompt template.
---

# cutit-few-shot-trimming

Few-shot examples are copied into every call that uses the template, so any excess — an extra example that doesn't teach a new case, or a verbose example where a terse one would demonstrate the same pattern — is a recurring cost multiplied across every future call, not a one-time expense.

## Protocol

- Start from the fewest examples that cover the distinct cases the task confuses (often 1-3), and add more only when testing shows a specific failure mode the current set doesn't teach.
- When two examples teach the same pattern, keep the clearer one and drop the redundant one rather than keeping both "for reinforcement."
- Trim each example to the minimum input/output needed to demonstrate the pattern — strip surrounding narrative, comments, or realistic-but-irrelevant detail that isn't the thing being taught.
- Prefer one example that demonstrates an edge case over three that all demonstrate the common case — the common case usually needs no example at all if the instruction states it plainly.
- Re-test accuracy after each removal; stop trimming at the first example whose removal measurably drops quality, and keep that one.

## When not to cut

If the task is format-sensitive or the model reliably drifts from the exact output shape without a full worked example (e.g. a rare structured format, a house style with no other anchor), keep the example at full length — a trimmed example that omits the format cue defeats its own purpose.
