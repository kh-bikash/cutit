---
name: cutit-tool-schema-pruning
description: Catches carrying tool definitions the current task will never invoke — invoke when configuring an agent's toolset or noticing a long tool list where most entries are clearly out of scope for the task at hand.
---

# cutit-tool-schema-pruning

Every tool definition in an agent's toolset is paid on every single turn as part of the system prompt, whether or not that tool is ever called. A toolset carrying twenty tools for a task that touches three pays that overhead for the whole session, not just once.

## Protocol

- Before a session starts (or at configuration time), scope the toolset down to what the task category actually needs — a code-review task doesn't need deployment tools, a docs task doesn't need a database client.
- When building an agent or subagent definition, list only the tool families relevant to its job description, not "everything available" as a safe default.
- If a tool platform supports per-task or per-agent tool subsets (as opposed to one global list), use that mechanism rather than one maximal list shared across all tasks.
- Periodically audit a long-lived agent's toolset for tools that have never actually been called across recent sessions — those are candidates to drop.
- Prefer one flexible tool over three narrow overlapping ones if the narrow ones together cost more schema tokens than the task ever recoups in savings.

## When not to cut

If the task's scope is genuinely uncertain up front (an open-ended assistant, an exploratory session where the next request is unknown), keep the broader toolset rather than guessing wrong and having to reconfigure mid-session — a missing tool blocks the task outright, which costs far more than the unused schema tokens.
