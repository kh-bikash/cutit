---
name: cutit-result-digestion
description: Catches a sub-agent handing its full raw transcript, file dumps, or exploration log back to the parent instead of a compressed summary — the parent then re-reads all of it, doubling the cost of everything the sub-agent already processed. Invoke when a delegated agent is about to report its results back to its caller.
---

# cutit-result-digestion

The whole point of delegating exploration is to keep the bulk of it out of
the parent's context. That benefit disappears if the sub-agent's final
message pastes back every file it read and every command it ran — the
parent ends up holding the same volume of tokens it delegated away.

## Protocol

- End a delegated task with a compressed answer: the conclusion, the
  specific file paths and line numbers that matter, and only the snippets
  that are load-bearing for the parent's next decision.
- Don't restate full file contents already implied by a path/line
  reference — the parent can re-read that spot itself if it ever needs to,
  which is rare.
- Report what was ruled out as a one-line conclusion ("checked auth.py,
  timeout logic, not the bug"), not the transcript of ruling it out.
- Cap length explicitly when the calling instructions don't already ("under
  200 words") if the investigation was broad, so the digest doesn't grow to
  match the exploration it's supposed to replace.

## When not to cut

If the parent's next step is to make a judgment call that hinges on exact
wording, exact diff content, or numeric precision, include that verbatim
piece even if it's long — a paraphrase that loses precision can cause the
parent to act on a wrong reading, which costs more than the tokens saved.
