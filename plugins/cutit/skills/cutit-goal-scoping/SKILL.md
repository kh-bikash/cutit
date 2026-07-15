---
name: cutit-goal-scoping
description: Catches over-delivering on a vague request — reading, searching, or building far more than the ask requires because the boundary was never pinned down. Invoke when a request is ambiguous in scope, before starting any exploration or execution.
---

# cutit-goal-scoping

An ambiguous ask ("clean up this module," "check the auth flow") has no
natural stopping point, so an agent without a defined boundary tends to keep
reading and keep touching files well past what satisfies the actual need.
The tokens spent past the real boundary are pure waste, not extra safety.

## Protocol

- Restate the ask as the smallest deliverable that would make the user say
  "yes, that's it" — write that restatement down before touching any tool.
- If the ask names a file, function, or feature, treat everything outside
  that boundary as out of scope unless the fix demonstrably requires it.
- Prefer one targeted clarifying question over silently picking the
  broadest interpretation "to be safe" — a question costs a turn; an
  over-broad execution costs a full unnecessary pass.
- When scope is genuinely unclear but low-stakes, state the assumed scope
  in your first response and proceed — cheaper than blocking on a question
  for a reversible assumption.
- Resist expanding scope mid-task just because you noticed an unrelated
  improvement opportunity; note it, don't chase it.

## When not to cut

If narrowing the scope would silently leave the actual bug or requirement
unaddressed (the vague ask is vague because the user doesn't know where the
problem is), don't guess small — investigate enough to locate the real
boundary, or ask, before committing to a scope.
