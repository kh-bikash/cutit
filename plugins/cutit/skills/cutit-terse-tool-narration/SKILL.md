---
name: cutit-terse-tool-narration
description: Catches announcing every routine tool call in a full sentence ("Now I'll read the file to check X") before making it — invoke before any expected, unsurprising tool call in a sequence.
---

# cutit-terse-tool-narration

A tool call that does exactly what the plan already implied doesn't need a sentence of preamble — the call itself is the record of what happened. Narrating each one anyway ("Let me check...", "Now I'll search for...") adds a full clause of tokens per call across a long tool sequence, and it compounds fast in loops that make dozens of calls.

## Protocol

- Make routine, expected tool calls without a preceding sentence when the plan already established what's next — the call and its result speak for themselves.
- Reserve narration for moments that need it: a surprising result, a change in direction, or a decision point where the next step isn't the obvious continuation of the last.
- When several calls in a row serve one purpose (checking three related files, running a few independent greps), narrate the purpose once, not once per call.
- After a batch of silent calls, summarize what was found in one line rather than describing what each call was for after the fact.

## When not to cut

If the user is watching the process to learn or audit it (a debugging session where they want to follow the reasoning, or a task where trust in the method matters as much as the result), narrate enough that they can follow the thread — silence there reads as opacity, not efficiency.
