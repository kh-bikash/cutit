# Pre-flight checklist

Run through this before a read, search, or write that feels "big." If every
answer is "yes, needed," proceed — this isn't a rule to block on, it's a
gut-check to catch the reflexive over-fetch.

## Before reading a file

- [ ] Do I already know which lines matter (from a grep hit, an error
      trace, a line number the user gave me)? → use `offset`/`limit`.
- [ ] Have I already read or edited this file this session? → don't
      re-read it, the content you have is current.
- [ ] Am I reading the whole file "just in case"? → grep for the symbol
      instead and read around the hit.

## Before searching

- [ ] Do I know the exact name/string I'm looking for? → Grep/Glob
      directly, don't delegate.
- [ ] Is this open-ended ("where is X handled," "how does Y flow through
      the app") and likely to take 3+ exploratory rounds? → delegate to a
      search-focused agent instead of exploring inline.
- [ ] Am I about to spawn an agent for something I could just do myself
      with the context I already have loaded? → don't spawn.

## Before writing/editing

- [ ] Is this an existing file with a small, localized change? → Edit,
      not Write.
- [ ] Am I about to paste a full file/log/diff into my own output when a
      summary plus a file link would answer the question? → summarize.
- [ ] Am I about to write an intermediate planning doc that I'll read
      back in later? → use task tracking instead.

## Before calling a tool with unbounded output

- [ ] Does this tool support a result cap (`head_limit`, `-n`, page size)?
      → set it to what you actually need, not the max.
- [ ] Is the raw output going to be consumed by a human, or do I just need
      a count/boolean/single value out of it? → pipe/filter down to that
      before it re-enters context.

## Red flags that you're over-spending

- Reading the same file twice in one session.
- A tool result you didn't bound scrolling past what you needed.
- Spawning an agent to do something you were about to do anyway.
- A planning doc you wrote, then immediately read back in full.
- Pasting a full diff/log into your response when a two-line summary
  would have answered the question.
