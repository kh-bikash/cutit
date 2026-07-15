---
name: cutit-incremental-validation
description: Catches the pattern of running every step of a multi-step task back to back and only checking output at the end, where an early failure has already compounded through later steps built on it. Invoke when executing a task with more than two sequential steps, each depending on the last.
---

# cutit-incremental-validation

If step 2 is wrong and steps 3 through 6 are built on it, discovering the failure at the end means redoing five steps instead of one — and re-reading whatever context those five steps produced along the way. Checking after each step turns a compounding failure into a single cheap retry.

## Protocol

- After each step in a dependent chain, run the cheapest check that confirms this step's output is usable before starting the next one (a quick read-back, a type check, a single assertion).
- Stop at the first failing step rather than pushing through the rest of the plan on a broken foundation — the remaining steps' output is worthless if this one is wrong.
- Keep the per-step check proportional to that step's risk: a mechanical transformation needs a glance, a step involving judgment calls needs a real look.
- Carry forward only the validated output of each step, not the intermediate reasoning that produced it — the next step needs the result, not the process.
- When a step fails, fix it in place and re-validate before advancing, instead of noting the failure and continuing so it can be "fixed later."

## When not to cut

If the steps are actually independent (not sequentially dependent), running them all and checking once at the end is fine — per-step validation only pays for itself when a failure would otherwise propagate into subsequent work.
