---
name: cutit-tool-output-formatting
description: Catches requesting prose or verbose formatting from a tool/subroutine when the agent itself is the only consumer of the result — invoke whenever a tool call's output feeds straight into another step rather than a human-facing reply.
---

# cutit-tool-output-formatting

When a tool's result is read only by the calling agent (not shown to the user), verbose formatting — full sentences, markdown tables, repeated field labels — costs tokens on both the output and the re-read, with no one around to benefit from the readability. IDs, counts, and terse structured fields carry the same information at a fraction of the size.

## Protocol

- When configuring a tool or writing a prompt that queries one, ask for compact structured output (a bare list of IDs, a count, a JSON object with short keys) if the result only feeds the next step.
- Avoid asking a tool or sub-call to "explain" or "describe" its result when the caller only needs a decision-relevant value out of it.
- Strip formatting meant for human readability — headers, bullet prose, repeated labels — from intermediate results that never reach the user.
- Reserve full prose/markdown output for the final, user-facing response, not for the scaffolding steps that produce it.
- If a tool's default output mode is verbose, check for a terser mode (count-only, id-only, compact JSON) before accepting the default.

## When not to cut

If the output is going to be shown to the user verbatim, or if terseness would strip context a later step needs to reason correctly (e.g. collapsing a diff to a count when the next step needs to inspect the actual lines), keep the fuller format — the goal is cutting redundant restatement, not information the task still needs.
