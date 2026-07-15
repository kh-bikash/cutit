---
name: cutit-scratchpad-offloading
description: Catches keeping large intermediate state (accumulated notes, partial results, a growing list) live in the prompt across many turns instead of writing it to a scratch file and reading back only what's needed — invoke whenever intermediate state needs to survive more than a couple of turns.
---

# cutit-scratchpad-offloading

Intermediate working state that an agent keeps repeating back to itself turn after turn (a running list of findings, partial computation, accumulated notes) gets re-sent in full every single turn it stays in the live prompt. Writing it to a scratch file trades one small write for removing that state from the recurring per-turn cost entirely — it's retrieved only when actually needed again.

## Protocol

- When intermediate state will be referenced across several more turns, write it to a scratch file rather than restating it in the conversation each time.
- Read back only the specific piece of the scratch file relevant to the current step, not the whole file, when it later grows large.
- Update the scratch file in place as state changes, rather than keeping a live copy in context that also needs updating in parallel.
- Use the scratchpad for state the agent itself needs later, not for information meant for the user — user-facing content still belongs in the response.
- Once the scratchpad's contents are no longer needed for the rest of the task, stop reading from it rather than continuing to reload it out of habit.

## When not to cut

If the state is small and only needed for the very next step, writing it to a file and reading it back costs more (a write, then a read) than just keeping it live for one more turn — offload state that persists across several turns, not state you're about to consume immediately.
