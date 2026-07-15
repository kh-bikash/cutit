---
name: cutit-escalation-on-failure
description: Catches the reflex of defaulting straight to the most expensive model or highest-effort attempt "to be safe," when a cheap attempt would have succeeded most of the time. Invoke when starting a task whose difficulty is unknown and a cheap first try is verifiable.
---

# cutit-escalation-on-failure

Many tasks succeed on a cheap model or a low-effort first pass; paying premium cost upfront for every attempt burns tokens on the cases that didn't need it. The fix is to try cheap first and escalate only when the cheap attempt demonstrably fails — not to guess in advance which tier a task needs.

## Protocol

- Attempt the task with the cheaper model/lower-effort config first, when the attempt is cheap to verify (test passes, output matches an expected shape, a quick self-check succeeds).
- Define the failure signal before starting: what makes this attempt count as "failed" (wrong test result, malformed output, unmet constraint) — vague dissatisfaction isn't a valid escalation trigger.
- On failure, escalate once to the stronger model/effort tier, carrying forward what was learned (the failed attempt and why) instead of restating the task from scratch.
- Cap escalation at one or two tiers — repeatedly retrying at the same or a lower tier after a clear failure just accumulates cost without changing the odds.
- Skip the cheap attempt only when you already know from prior context that this exact task class fails at that tier — don't relearn that lesson each time.

## When not to cut

If failure is expensive or hard to detect (a bug that ships silently, a wrong answer that looks plausible), don't gate on "try cheap first" — start at the tier that gives you confidence in the result, since an undetected cheap-tier failure costs far more than the escalation would have.
