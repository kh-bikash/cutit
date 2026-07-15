---
name: cutit-graceful-degradation
description: Catches escalating spend (bigger model, more retries, deeper search) chasing an ideal approach that's failing, when a cheaper fallback would satisfy the actual requirement. Invoke when a preferred method has failed once or twice and a simpler alternative exists.
---

# cutit-graceful-degradation

Agentic loops tend to double down: the first approach fails, so the instinct is to try it harder — bigger context, another tool, a stronger model — rather than asking whether a cheaper method already clears the bar. Chasing perfect when good-enough is acceptable spends tokens on the gap between the two.

## Protocol

- Before escalating (retrying with more context, switching to a costlier tool/model), check whether a simpler fallback already satisfies the actual requirement, not just the originally-attempted method.
- Name the requirement in concrete terms (what does "done" require here) so you can tell whether the fallback meets it, instead of degrading by default.
- Prefer a fallback that's a known-reliable simpler path (a heuristic, a cached prior result, a less precise but correct method) over one more attempt at the ideal path with more resources thrown at it.
- State the degradation explicitly when you take it ("using X instead of Y because Y failed twice and X meets the requirement") so the user can override if the gap actually matters to them.
- Keep a note of what the ideal path needed to succeed, in case the user wants it revisited later — degrading isn't abandoning the better approach, just not paying to chase it now.

## When not to cut

If the task's correctness genuinely depends on the failing method's precision (a fallback would produce a subtly wrong answer, not just a rougher one), escalate or ask instead of degrading — silent quality loss dressed up as efficiency is the failure mode this skill exists to avoid, not enable.
