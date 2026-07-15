# cutit swarm — index (built)

108 skills about **agentic patterns themselves** — how an agent plans,
delegates, retrieves, verifies, and hands off work. Same philosophy as
core [cutit](plugins/cutit/skills/cutit/SKILL.md): narrow before you
fetch, cap what comes back, don't redo work you already paid for —
applied to the mechanics of agent loops instead of specific tech stacks.

All 108 are built, one directory each at
`plugins/cutit/skills/cutit-<pattern>/SKILL.md`, following the core
skill's frontmatter/Protocol/"when not to cut" shape. This file is now an
index — use it to find a skill by pattern, and to decide which ones to
actually install (see [README.md](README.md)).

**Naming convention:** `cutit-<pattern>`, e.g. `cutit-task-decomposition`.

**Overhead tension, same as noted in the README:** every installed skill
adds a line to the always-on skill listing. Install only the categories
relevant to how you actually build/run agents.

**Installable as 5 themed plugins**, not just the all-in-one `cutit`
bundle — categories below map to plugins like this (full cost comparison
in [README.md](README.md#install)):

| Categories | Plugin |
|---|---|
| A (Planning), B (Delegation), F (Pipelines) | `cutit-agents` |
| C (Tool use), G (Retrieval), H (Prompting) | `cutit-tooling` |
| D (Context), J (Sessions), K (Recovery), L (Caching), M (Search), N (State), O (Routing) | `cutit-runtime` |
| E (Verification), I (Output), P (HITL), Q (Eval/guardrails) | `cutit-quality` |
| R (Domain roles) | `cutit-domains` |

---

## A. Planning & task decomposition (8)

1. `cutit-task-decomposition` — size steps to avoid re-planning; one solid plan costs less than three false starts.
2. `cutit-plan-revision` — patch an existing plan when scope changes instead of regenerating it whole.
3. `cutit-goal-scoping` — narrow an ambiguous ask to the smallest scope that satisfies it before executing.
4. `cutit-step-sizing` — steps sized so per-step verification stays cheap — not so fine-grained that overhead dominates, not so coarse that failures are expensive to isolate.
5. `cutit-plan-caching` — reuse a plan template for a recurring task type instead of re-deriving it each time.
6. `cutit-dependency-ordering` — run the cheap check before the expensive one so a plan fails fast, before downstream tokens are spent.
7. `cutit-early-termination` — recognize the goal is already met and stop, instead of running the rest of a fixed plan regardless.
8. `cutit-checkpoint-planning` — checkpoint long plans so a failure resumes from the last checkpoint, not step one.

## B. Sub-agent delegation & orchestration (9)

9. `cutit-delegation-threshold` — a concrete rule for when a sub-task is separable enough to delegate vs. just doing it inline.
10. `cutit-context-handoff` — pass a sub-agent the minimum context it needs, not the full parent transcript.
11. `cutit-parallel-delegation` — fan out independent sub-tasks concurrently instead of serial spawns that each wait on the last.
12. `cutit-agent-reuse` — resume an idle agent with new context instead of spawning fresh and re-deriving everything.
13. `cutit-result-digestion` — a delegated agent returns a compressed summary, not its full raw transcript, to the parent.
14. `cutit-orchestrator-lean` — keep the orchestrator's own context free of work it delegated, so it isn't held twice.
15. `cutit-fan-in-summarization` — merge multiple sub-agent results in one summarization pass instead of re-reading each in full.
16. `cutit-spawn-avoidance` — "don't spawn what you can just do," formalized with concrete trigger conditions.
17. `cutit-subagent-scoping` — give a sub-agent a narrow, closed task instead of an open-ended one that invites its own unbounded exploration.

## C. Tool use & tool-schema management (8)

18. `cutit-lazy-tool-loading` — load a tool's full schema right before calling it, not at session start.
19. `cutit-tool-selection` — pick the narrowest-scope tool for the job so both the call and its result stay small.
20. `cutit-tool-result-capping` — default every tool call to a result limit/page size; widen only on demand.
21. `cutit-tool-call-batching` — batch independent tool calls in one turn instead of serial round-trips that restate context each time.
22. `cutit-tool-schema-pruning` — drop tool definitions the current task will never touch.
23. `cutit-function-calling-minimalism` — design function signatures with the fewest parameters that fully specify the call — schema tokens are paid on every call.
24. `cutit-tool-output-formatting` — request compact structured output (ids/counts) instead of verbose prose when the agent is the only consumer.
25. `cutit-retry-without-reload` — retry a failed tool call without re-sending context that was already in the failed attempt.

## D. Context window & memory budgeting (9)

26. `cutit-context-budget-tracking` — track remaining context budget and compact proactively, before a hard limit forces truncation mid-task.
27. `cutit-proactive-compaction` — summarize and drop resolved sub-threads before they'd be forced out anyway.
28. `cutit-relevance-filtering` — keep only what's relevant to the current step; don't carry the full history "just in case."
29. `cutit-memory-scoping` — retrieve only the memory entries relevant to this turn, not a full memory dump.
30. `cutit-working-set-minimization` — keep the active working set (open files, live variables) as small as the current step needs.
31. `cutit-stale-context-pruning` — drop context proven stale (a file since re-read, a plan since revised) instead of letting old and new both linger.
32. `cutit-rolling-summary` — maintain a running summary of a long session instead of keeping full turn-by-turn history live.
33. `cutit-scratchpad-offloading` — write intermediate state to a scratch file instead of keeping it live in the prompt across many turns.
34. `cutit-selective-recall` — a memory/history query returns the matching slice, not the whole store.

## E. Verification & self-checking (7)

35. `cutit-cheap-precheck` — run a fast check (lint, type-check, smoke test) before an expensive full verification pass.
36. `cutit-targeted-verification` — verify only what a change actually touches when the blast radius is known, not the whole system.
37. `cutit-single-pass-confidence` — spend enough tokens to get it right once, rather than a fast wrong answer plus a correction cycle.
38. `cutit-diff-verification` — verify a change against the diff, not the whole resulting file.
39. `cutit-assertion-first` — write the expected outcome before generating the full solution, so a mismatch is caught before elaboration continues.
40. `cutit-incremental-validation` — validate each step of a multi-step task as it completes, so errors are caught before they compound.
41. `cutit-golden-path-testing` — verify the primary path cheaply before exhaustively verifying edge cases nobody's hit yet.

## F. Multi-agent pipelines & handoff (7)

42. `cutit-pipeline-stage-isolation` — each stage gets only the prior stage's output, not the full upstream history.
43. `cutit-handoff-summarization` — summarize before handing off between agents/stages instead of forwarding raw transcripts.
44. `cutit-role-specialization` — narrow role/context per agent in a pipeline so none re-derive what another already established.
45. `cutit-shared-state-store` — pass state through a shared reference instead of re-transmitting it in every inter-agent message.
46. `cutit-pipeline-short-circuit` — let an early stage terminate the pipeline when its own check already answers the request.
47. `cutit-consensus-minimalism` — when multiple agents cross-check the same output, compare compressed verdicts, not full re-derivations.
48. `cutit-pipeline-caching` — cache a stage's output when its inputs haven't changed, instead of recomputing every run.

## G. Retrieval / RAG in agent loops (7)

49. `cutit-chunk-sizing` — size retrieved chunks to the minimum that preserves needed context, not maximal "to be safe."
50. `cutit-top-k-tuning` — tune retrieval top-k to what the task needs instead of over-fetching and filtering after.
51. `cutit-rerank-before-stuff` — rerank candidates before they enter the prompt, not after paying to include the irrelevant ones.
52. `cutit-query-rewriting` — rewrite a vague query into a precise one before retrieval, so the first fetch is the last fetch.
53. `cutit-retrieval-caching` — cache retrieval results for repeated/similar queries within a session.
54. `cutit-citation-scoping` — return the cited passage, not the full source document, back to the model.
55. `cutit-multi-hop-retrieval-budget` — cap retrieval hops in a multi-hop loop, escalating only when a cheap hop count fails.

## H. Prompt & context construction (7)

56. `cutit-cache-aware-prompting` — stable content first, volatile last, to maximize prompt-cache hits across calls.
57. `cutit-few-shot-trimming` — trim few-shot examples to the minimum count/length that preserves accuracy.
58. `cutit-system-prompt-diet` — keep system prompts free of instructions the current task doesn't exercise.
59. `cutit-dynamic-prompt-assembly` — assemble a prompt from modular sections included only when relevant, not one static maximal template.
60. `cutit-instruction-dedup` — don't repeat the same instruction across system/user/tool messages.
61. `cutit-template-reuse` — reuse a fixed template's cached prefix across calls instead of reformatting per call.
62. `cutit-context-injection-scoping` — inject only the specific fields an agent needs from a larger object, not the whole thing serialized.

## I. Output shaping & response discipline (6)

63. `cutit-structured-output` — request structured/short-form output when nothing needs to read prose, cutting generation tokens.
64. `cutit-response-length-budgeting` — set a length budget appropriate to the question instead of defaulting to maximal elaboration.
65. `cutit-no-restate` — don't restate the user's request or an already-agreed plan before answering.
66. `cutit-diff-only-output` — show only changed lines/fields, not the full before/after state.
67. `cutit-summary-first` — lead with the answer, expand only if asked, instead of building up to it.
68. `cutit-terse-tool-narration` — skip narration before routine, expected tool calls; narrate only surprises or direction changes.

## J. Session & long-running task management (6)

69. `cutit-session-resumability` — checkpoint enough state to resume a long task from the last good point, not restart cold.
70. `cutit-idle-agent-reuse` — resume a paused agent for a related follow-up instead of spawning new and re-deriving context.
71. `cutit-background-task-batching` — batch status checks on a long-running task instead of polling every few seconds.
72. `cutit-long-task-progress-compaction` — compact a finished phase into a one-line status once it's done, dropping detail that's no longer actionable.
73. `cutit-wakeup-scheduling` — schedule the next check-in at a cadence matched to how fast the watched state actually changes.
74. `cutit-multi-session-continuity` — persist only the durable facts a future session needs, not full transcripts.

## K. Error recovery & retry (7)

75. `cutit-root-cause-first-retry` — diagnose root cause from the first failure before retrying blindly, avoiding repeated full-cost failed attempts.
76. `cutit-partial-retry` — retry only the failed step of a multi-step task, not the whole task.
77. `cutit-error-triage-budget` — cap raw error output pulled into context before triage narrows to the relevant frame/line.
78. `cutit-backoff-without-context-bloat` — retry with backoff without re-appending the same failed context each attempt.
79. `cutit-known-failure-shortcuts` — recognize a previously-seen failure signature and apply the known fix instead of re-diagnosing from scratch.
80. `cutit-graceful-degradation` — fall back to a cheaper, good-enough method when the ideal one fails, instead of escalating spend chasing it.
81. `cutit-failure-scoped-logging` — capture only the failing case's logs, not the whole run's.

## L. Caching & reuse across turns (6)

82. `cutit-result-memoization` — cache a deterministic computation/tool result within a session instead of recomputing it if asked again.
83. `cutit-cross-turn-dedup` — recognize a later turn asks for something already computed and reuse it instead of redoing the work.
84. `cutit-artifact-reuse` — reuse a previously generated artifact instead of regenerating it whole for a small requested tweak.
85. `cutit-prompt-cache-preservation` — avoid unnecessary edits to a stable prefix that would invalidate a warm prompt cache.
86. `cutit-precomputed-index-reuse` — build a search index/summary once per session and reuse it across multiple queries.
87. `cutit-config-reuse` — reuse resolved configuration/environment facts already established this session instead of re-querying per step.

## M. Search & exploration strategy (7)

88. `cutit-breadth-vs-depth` — choose targeted-depth search over broad exploration when the target is already well specified.
89. `cutit-explore-then-commit` — cap exploratory search rounds, then commit to the best candidate instead of searching open-endedly.
90. `cutit-negative-result-shortcut` — stop once a negative result answers the question, instead of exhausting every location to prove it.
91. `cutit-search-index-first` — check an existing index/cache before falling back to a live/raw search.
92. `cutit-progressive-widening` — start narrow and widen scope only on a miss, instead of starting broad by default.
93. `cutit-known-location-shortcuts` — go straight to the conventional location for something before searching broadly.
94. `cutit-search-result-triage` — read the top few most-relevant hits in full; skim the rest by title/snippet.

## N. State tracking (plans/todos/memory) (4)

95. `cutit-external-state-over-recap` — track plan/todo state in structured tracking instead of a natural-language recap re-typed each turn.
96. `cutit-memory-write-discipline` — write only durable, non-derivable facts to persistent memory; skip what's re-derivable from code/logs.
97. `cutit-state-diffing` — update tracked state with a diff/patch, not a full rewrite, each time it changes.
98. `cutit-todo-granularity` — size todo items so tracking overhead doesn't exceed the value of tracking a trivial step.

## O. Model routing & cost-aware execution (4)

99. `cutit-difficulty-based-routing` — route mechanical subtasks to a cheaper/faster model; reserve the strongest model for steps that need its reasoning.
100. `cutit-escalation-on-failure` — start with a cheap model/attempt and escalate only if it fails, instead of defaulting to the expensive one.
101. `cutit-batch-vs-realtime` — use batch/async processing for non-urgent bulk work instead of paying real-time-priority cost for it.

## P. Human-in-the-loop & clarification (3)

102. `cutit-clarify-before-commit` — ask one clarifying question when genuinely ambiguous instead of guessing and redoing the task at full cost.
103. `cutit-confirmation-batching` — batch related confirmations into one question instead of several round-trips.
104. `cutit-preference-capture` — capture a stated user preference once (memory/config) instead of re-asking or re-deriving it every session.

## Q. Evaluation & guardrails (4)

105. `cutit-sampled-eval-review` — review a representative sample of eval failures instead of every transcript.
106. `cutit-metric-first-triage` — triage by aggregate metrics before opening individual failing cases.
107. `cutit-cheap-guardrail-first` — run a cheap rule-based check before an expensive model-based safety/quality check.
108. `cutit-fail-fast-guardrails` — place the cheapest guardrail earliest in a pipeline so a violation is caught before expensive downstream steps run.

## R. Domain roles (3)

109. `cutit-frontend` — source over bundles, capped devtool/console logs, grep-before-read for components/styles, targeted screenshots over full-page dumps.
110. `cutit-backend` — bounded queries, diffed migrations, capped stack traces, log grep by request/trace id instead of full tails.
111. `cutit-design` — grep-then-diff for design systems/tokens, Figma specs, ADRs, and architecture/interface docs, instead of reading them whole.

---

**Total: 111 skills built** (plus the existing core `cutit`, 112 total).

## Status

Built in 8 parallel batches. Every file was verified on disk: correct
path, valid frontmatter, no placeholder/truncated content, and spot-checked
across batches for genuine (non-boilerplate) protocols and guardrails.
Nothing here is speculative anymore — if a skill name above doesn't match
what you need, edit or remove that skill's folder directly rather than
editing this index alone.
