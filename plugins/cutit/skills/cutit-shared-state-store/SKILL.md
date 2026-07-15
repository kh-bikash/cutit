---
name: cutit-shared-state-store
description: Catches the pattern of re-transmitting the same state (full config, accumulated results, running context) in every message between agents instead of passing a reference to where it already lives. Invoke when an inter-agent message would otherwise repeat data already sent in a prior message.
---

# cutit-shared-state-store

Re-sending the same accumulated state in every message of a multi-turn agent exchange multiplies its token cost by the number of messages — a fact transmitted once and referenced thereafter costs a fraction of the same fact retransmitted on every round trip.

## Protocol

- Put state that multiple agents or turns need into a shared reference (a file, a task-tracker entry, a named variable in a store) instead of pasting it into each message.
- Pass a pointer or short identifier to that state in subsequent messages, and let the receiving side fetch it only if it doesn't already have it.
- Update the shared store in place when state changes, rather than sending a full new copy of the state alongside the update.
- Reserve inline transmission for state that's small, one-shot, or won't be needed again — the store is worth the indirection only when the same data would otherwise cross the wire more than once.
- Make sure the reference itself is unambiguous (a stable file path, a versioned key) so the receiving agent doesn't have to guess which version of the state it's looking at.

## When not to cut

If the receiving agent has no reliable way to fetch from the shared store (no file access, no shared memory, a genuinely stateless call), inline the needed state directly — a reference to unreachable state is worse than the tokens saved.
