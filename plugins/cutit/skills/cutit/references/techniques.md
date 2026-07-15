# Why each rule pays off

Token cost in an agentic session comes from three places: what you read in,
what tools return to you, and what you write out (including everything a
sub-agent has to re-derive from scratch). Every technique here attacks one
of those three, without touching the actual reasoning quality of the task.

## Read narrow, not wide

A 2,000-line file read in full costs roughly the same whether you need 3
lines or all 2,000. Grepping for the symbol first, then reading with
`offset`/`limit` around the hit, gets you the same lines at a fraction of
the cost — and the harness already tracks what you've read/edited this
session, so re-reading a file you touched five turns ago is pure waste; the
content hasn't changed underneath you.

*Before:* read a 1,500-line config file to find one setting.
*After:* grep the setting name, read 20 lines around the match.

## Search with the cheapest tool

Dedicated search tools (grep/glob equivalents) return structured,
boundable matches. A shell pipeline that cats a whole tree and filters
client-side pulls every byte through the model first. Reserve delegated,
multi-step research for genuinely open-ended questions — "where does this
concept live across the codebase" — where the alternative is 10+
exploratory reads cluttering your own context instead of coming back as
one digested answer.

## Don't spawn what you can just do

A fresh agent has no memory of the current conversation. Spawning one to
finish a task you're already mid-way through means paying to re-explain
everything you've already learned, in exchange for... doing the same task.
Delegation only pays off when the sub-task is separable enough that its
exploration would otherwise bloat the main thread, or when it can run in
parallel with other work.

## Cap everything that comes back

An unbounded search or log dump costs you tokens whether or not you end up
using most of it. Setting a result cap up front (and re-running with a
higher cap only if you actually need more) almost always costs less than
the alternative of pulling everything and skimming.

## Edit, don't rewrite

A diff-based edit transmits the change. A full-file write transmits the
entire file, including everything that didn't change. For any edit to an
existing file, the diff is a strict subset of the full-file cost.

## Track state instead of writing it back into context

A planning doc written to disk and then read back in has been paid for
twice: once to write, once to re-read. A structured task list held in the
harness's own state doesn't round-trip through the model to be
reconstructed — it's just there.

## Load tool/schema detail lazily

Every tool definition loaded into context costs tokens whether or not it's
ever called. An environment that supports on-demand tool schemas lets you
pay only for the tools a given task actually touches, instead of every tool
that might conceivably be relevant.

## Structure prompts for cache hits

If you're constructing prompts for your own agent or app: providers that
support prompt caching charge full price the first time a prefix is seen
and a fraction on repeats — but only if that prefix is byte-identical and
stays at the front. Stable system instructions first, per-request content
last, and no edits to the stable part, is what keeps the cache warm across
calls instead of invalidating it every time.

## Route by difficulty

Not every step in a multi-step task needs the strongest available model.
A mechanical reformat, a boilerplate extraction, a simple classification —
these succeed just as reliably on a smaller, cheaper model. Reserve the
expensive model for the step that actually needs its reasoning; routing
everything through it by default spends the same budget for no quality
gain on the easy steps.

## Say less, don't know less

Terse narration is a free cut — a shorter accurate sentence costs less
than a longer one and loses nothing. This is the one technique that's
purely about output, never about the underlying investigation: cutting the
write-up is fine, cutting the work that produced it is not.
