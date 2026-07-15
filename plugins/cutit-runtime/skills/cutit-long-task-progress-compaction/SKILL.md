---
name: cutit-long-task-progress-compaction
description: Catches keeping the full detail of a finished phase in context after it's no longer actionable — invoke right after any phase of a multi-step task completes, before moving to the next one.
---

# cutit-long-task-progress-compaction

The detailed record of how a completed phase was done — every file read, every intermediate attempt, every tool call — stops being useful the moment the phase closes out; only the outcome matters to the phases still ahead. Carrying that detail forward in context anyway means every later step re-reads it as part of the conversation history, paying for it repeatedly instead of once.

## Protocol

- When a phase finishes, collapse its record to one line: what was done, and the outcome — drop the blow-by-blow of how it got there.
- Keep the compacted line only if a later phase could plausibly need to reference the outcome; if not even that's needed, drop it entirely rather than keeping it "for the record."
- Do this compaction proactively at natural phase boundaries, not only when context pressure forces it — waiting until it's full means compacting under worse conditions.
- Prefer updating a running status/tracker entry in place over appending a new detailed paragraph each time a phase completes.

## When not to cut

If a later step needs to justify or re-derive a decision made in an earlier phase (why a particular approach was chosen, what alternatives were rejected and why), keep that specific reasoning rather than compacting it away — compact the mechanics of execution, not the decisions that still bind later work.
