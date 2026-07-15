---
name: cutit-checkpoint-planning
description: Catches restarting a long multi-step task from step one after a mid-task failure, re-doing and re-verifying already-completed work instead of resuming from where it broke. Invoke when planning a long-running or many-step task that could fail partway through.
---

# cutit-checkpoint-planning

A failure at step 8 of 10 doesn't undo steps 1 through 7. Re-running the
whole plan anyway — because the tracked state of "what's already done" was
never recorded durably — means re-paying for work that already succeeded
and was never invalidated.

## Protocol

- For any plan long enough that a mid-run failure is plausible, record
  completed steps in durable tracked state (task list, committed file
  changes) as you go, not just in conversational memory that a restart
  would lose.
- On resume after a failure, check tracked state first to find the last
  completed checkpoint, then re-verify only that one step's output before
  continuing — not the entire history.
- Make checkpoints line up with naturally verifiable boundaries (a passing
  test, a committed change) so "is this checkpoint still valid" is a cheap
  check, not a re-derivation.
- If the failure's cause might have corrupted earlier state (a bad shared
  edit, a partial write), re-verify back to the last point you're sure is
  clean — don't assume checkpoint validity blindly either.

## When not to cut

If the task is short enough to redo end-to-end for less than the cost of
building and checking a checkpoint, skip checkpointing — the bookkeeping
itself isn't free, and for a handful of steps a clean restart is cheaper.
