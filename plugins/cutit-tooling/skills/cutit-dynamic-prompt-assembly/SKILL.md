---
name: cutit-dynamic-prompt-assembly
description: Catches shipping one static maximal prompt template that includes every possible section on every call — invoke when designing a prompt template that serves more than one task variant or mode.
---

# cutit-dynamic-prompt-assembly

A single static template built to cover every scenario a system might face ends up including sections for scenarios that don't apply to most individual calls — tool docs for tools this task won't use, formatting rules for output types this call won't produce. Building the prompt from modular, conditionally-included sections instead means each call only pays for what it needs.

## Protocol

- Break the template into independent sections (per tool, per output format, per task mode) that can be included or omitted based on what the current call actually requires.
- Gate inclusion on a concrete signal — which tools are enabled, which mode was selected, what the task's declared type is — not on "include it in case it's needed."
- Keep the assembly logic itself simple and cheap (a lookup/conditional, not a model call) so the savings from smaller prompts aren't eaten by the cost of deciding what to include.
- When two modes share 90% of a section, factor out the shared part and append only the differing tail, rather than maintaining two near-duplicate full sections.
- Recompute which sections are needed at the point of assembly, not once at agent-init time — a task's needs can change mid-session as tools get enabled or the mode shifts.

## When not to cut

If the sections interact (an instruction in one section only makes sense given content from another that got excluded), don't assemble them independently — dynamic assembly that drops a dependency silently produces a prompt that reads as complete but is actually broken. Include the whole dependent group or none of it.
