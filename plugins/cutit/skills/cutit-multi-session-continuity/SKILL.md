---
name: cutit-multi-session-continuity
description: Catches persisting a full transcript or exploration log for a future session to read back in, when only a handful of durable facts are actually needed to pick the work back up — invoke when ending a session on a task that will continue later.
---

# cutit-multi-session-continuity

A future session resuming a task doesn't need to relive how the current one arrived at its conclusions — it needs the conclusions. Saving a full transcript "to be safe" means the next session pays to read all of it back in, most of which was exploratory dead ends, tool chatter, or reasoning that's already been distilled into a decision.

## Protocol

- At session end, write down only what a future session couldn't otherwise reconstruct cheaply: decisions made, current state, open questions, and where things were left off.
- Prefer a short structured note (state, next step, known blockers) over an exported transcript or log — the transcript is the source the note was distilled from, not something worth keeping alongside it.
- Name specific files/locations touched rather than describing the exploration that led to finding them — the future session can re-open a named file instantly; it can't cheaply replay a search.
- Overwrite or prune stale continuity notes when they're superseded, instead of accumulating one entry per session indefinitely.

## When not to cut

If the reasoning behind a non-obvious decision would be hard to reconstruct and matters to getting the next session right (why an approach was rejected, a subtle constraint discovered the hard way), keep that specific reasoning in the note — losing it risks the next session repeating the same dead end.
