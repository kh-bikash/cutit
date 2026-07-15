---
name: cutit-assertion-first
description: Catches the pattern of generating a full solution before establishing what "correct" looks like, so a wrong turn only surfaces after a long elaboration has already been built on it. Invoke before writing a nontrivial solution, function, or multi-step answer whose correctness can be stated as a check up front.
---

# cutit-assertion-first

Generating pages of solution before defining success means a wrong premise gets discovered only at the end, after every token spent elaborating on it has to be thrown away and redone. Stating the expected outcome first turns that into a cheap early exit.

## Protocol

- Before writing the solution, write down the concrete expected outcome — an assertion, an example input/output pair, a one-line success condition — in whatever form is cheapest (a comment, a test stub, a stated claim).
- Generate the solution against that stated target, checking as you go whether intermediate steps are still consistent with it.
- If the emerging solution contradicts the assertion, stop and resolve the contradiction immediately rather than finishing the draft and reconciling at the end.
- For code, prefer a real runnable check (a test, an assert, a one-line eval) over a prose restatement — it catches the mismatch mechanically instead of relying on you noticing.
- Keep the assertion itself short — one sentence or one test case is enough to anchor the work; don't spend more tokens specifying the target than the target is worth.

## When not to cut

If the correct outcome genuinely can't be known until the solution is explored (open-ended design work, exploratory debugging where the fix depends on what's found), don't force a premature assertion — investigate first and let the check emerge from what you learn.
