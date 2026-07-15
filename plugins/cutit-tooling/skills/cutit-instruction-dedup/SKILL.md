---
name: cutit-instruction-dedup
description: Catches the same instruction being stated in the system prompt, repeated in the user message, and repeated again in a tool description — invoke when assembling a multi-message prompt (system + user + tool schemas) for a task.
---

# cutit-instruction-dedup

Instructions get duplicated across message roles because each one is often written by a different part of a pipeline that doesn't check what the others already said — the system prompt states a formatting rule, the user template restates it "to be sure," and a tool description restates it again. The model pays to read every copy, and duplicates don't reinforce compliance more than stating it once clearly.

## Protocol

- Before adding an instruction, check whether it already exists in another message role for this call; if so, strengthen or relocate the existing one instead of adding a duplicate.
- Put each instruction in exactly one place: cross-call invariants in the system prompt, call-specific detail in the user message, and tool-usage constraints in that tool's description — not the same rule in more than one of these.
- When merging templates from different sources (a shared system prompt plus a task-specific addendum), diff them for overlap before concatenating.
- If an instruction needs emphasis, use structural emphasis (a heading, a bolded key phrase) once rather than restating the sentence two or three times in a row.
- Watch for accidental duplication introduced by dynamic assembly (a shared section pulled into both the system prompt and a per-call template) — dedupe at assembly time, not just at authoring time.

## When not to cut

If an instruction genuinely needs to survive a long context window's attention drop-off (a critical constraint far from the model's current focus late in a long conversation), a deliberate, sparing repeat near the point of use is a legitimate reliability technique — that's a designed reminder, not the accidental duplication this skill targets.
