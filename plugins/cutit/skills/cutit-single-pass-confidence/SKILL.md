---
name: cutit-single-pass-confidence
description: Catches the pattern of shipping a fast, under-investigated answer and then paying for a full correction cycle once it's found wrong. Invoke before answering or generating a solution when a wrong first attempt would trigger re-reading the same context to fix it.
---

# cutit-single-pass-confidence

A quick answer that turns out wrong doesn't just cost the redo — it costs re-loading everything you'd already have in context if you'd checked once. Two shallow passes plus a correction almost always outspend one pass done at the depth the task needed.

## Protocol

- Before answering, ask whether you actually have enough evidence for the specific claim you're about to make, not just enough to sound plausible.
- If a fact is checkable in one grep/read, check it now rather than asserting it and correcting later when challenged.
- Weight investigation depth to how expensive a wrong answer would be here: a wrong file path costs little to fix, a wrong architectural claim propagates into everything built on it.
- Do the extra verification step inline, in the same context you already have loaded — don't defer it to a "let me double check" follow-up turn that re-opens files you just closed.
- When genuinely uncertain after reasonable investigation, say so explicitly rather than guessing confidently — a flagged uncertainty is cheaper than a confident wrong answer someone acts on.

## When not to cut

If the cost of being wrong is genuinely low and easily caught (a quick reversible edit, a draft the user will review anyway), don't over-invest in certainty — spending three extra tool calls to be sure about something trivially fixable is its own waste.
