---
name: cutit-confirmation-batching
description: Catches the pattern of asking the user to confirm one small decision at a time across several round-trips, when the decisions are known upfront and could be resolved in a single combined question. Invoke when a plan surfaces more than one point that needs user sign-off before or during execution.
---

# cutit-confirmation-batching

Each confirmation round-trip re-pays context: the agent restates where it is, the user reads and replies, the agent re-reads the reply and resumes. Three sequential yes/no questions cost three of those round-trips when the underlying decisions were all knowable at plan time.

## Protocol

- Before starting execution, scan the plan for every point that will need user sign-off (destructive action, ambiguous choice, scope decision) rather than discovering them one at a time as you reach them.
- Present all of them together as one structured question (a short numbered list), so the user can answer all in one reply.
- Only break batching when a later decision genuinely depends on the answer to an earlier one — don't ask about something whose right answer only becomes knowable after an earlier step runs.
- Keep the batched question terse — a list of decisions and options, not a re-explanation of the whole task for each item.
- If new confirmation-worthy points surface mid-execution that weren't foreseeable, batch those separately rather than trickling them in one at a time either.

## When not to cut

If one confirmation is genuinely blocking (an irreversible action the user must approve before anything else can safely proceed), ask it immediately rather than holding it to batch with later, non-blocking questions — delaying it just to batch would stall or risk the wrong action being taken in the meantime.
