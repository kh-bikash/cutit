---
name: cutit-system-prompt-diet
description: Catches system prompts that accumulate instructions for tools, formats, or edge cases the current task never touches — invoke when writing or reviewing a system prompt that's grown large or covers many unrelated scenarios.
---

# cutit-system-prompt-diet

System prompts tend to grow by accretion — every edge case anyone ever hit gets a new paragraph, and none get removed once the immediate problem is fixed. Every one of those paragraphs is read on every single call regardless of whether the task in front of the model touches it, so a system prompt bloated with rarely-exercised instructions taxes every call to pay for a rare one.

## Protocol

- Include only instructions relevant to the tools, formats, and behaviors this deployment actually exercises — not every rule that might someday matter for a hypothetical broader use.
- When an instruction was added to fix one incident, check whether it generalizes; if it's a one-off, handle it in that call's user/task content instead of promoting it into the permanent system prompt.
- Periodically audit for instructions covering a tool or mode the agent no longer has access to, or a case that hasn't recurred since the instruction was added — remove them.
- Consolidate overlapping instructions that say the same thing in different words (often added at different times by different people) into one clear statement.
- Split a genuinely multi-mode agent's instructions into sections gated by mode, rather than one flat prompt where every mode's rules apply to every call — see cutit-dynamic-prompt-assembly for assembling only the relevant sections.

## When not to cut

If the agent operates in an open-ended or adversarial environment where an edge case could recur unpredictably (safety-relevant constraints, rare-but-costly failure modes), keep the guarding instruction in even if it's rarely triggered — the cost of the words is far lower than the cost of the one time it was needed and missing.
