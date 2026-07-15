# cutit

A swarm of Claude Code skills that cut token usage on agentic work without
cutting result quality. Every skill trades a cheap step (grep before read,
edit before rewrite, cap before dump, resume before respawn) for an
expensive one — none of them trade away correctness. Each skill carries its
own "when not to cut" guardrail for exactly that reason.

The swarm has three layers, all bundled in one installable plugin (see
[Install](#install) below):

- **[`cutit`](plugins/cutit/skills/cutit/SKILL.md)** — the core skill: a broad protocol
  covering the highest-value cuts (narrow reads, cheap search, capped tool
  output, edit-not-rewrite, lazy tool schemas, cache-aware prompting,
  model routing, terse narration) with a `references/` pair
  ([checklist](plugins/cutit/skills/cutit/references/checklist.md),
  [techniques](plugins/cutit/skills/cutit/references/techniques.md)) for pre-flight checks and
  rationale.
- **108 `cutit-<pattern>` skills** — narrow, single-file skills, one per
  specific agentic-workflow pattern (planning, sub-agent delegation,
  tool-schema management, context/memory budgeting, verification,
  multi-agent pipelines, RAG, prompt construction, output discipline,
  session management, error recovery, caching, search strategy, state
  tracking, model routing, human-in-the-loop, eval/guardrails). Full index
  in [SWARM.md](SWARM.md).
- **3 `cutit-<domain>` skills** — broader, role-shaped variants for the
  three pillars of building a product:
  [`cutit-frontend`](plugins/cutit/skills/cutit-frontend/SKILL.md) (source over bundles, capped
  devtool logs, targeted screenshots),
  [`cutit-backend`](plugins/cutit/skills/cutit-backend/SKILL.md) (bounded queries, diffed
  migrations, capped stack traces), and
  [`cutit-design`](plugins/cutit/skills/cutit-design/SKILL.md) (grep-then-diff for design
  systems, Figma specs, ADRs, and architecture docs).

## Install

This repo is a Claude Code **plugin marketplace** (`.claude-plugin/marketplace.json`
at the root) hosting one plugin, `cutit`, that bundles all 112 skills
under `plugins/cutit/skills/`. It's live at
[github.com/kh-bikash/cutit](https://github.com/kh-bikash/cutit) — anyone
with Claude Code can install it in two steps, run inside Claude Code
itself:

```
/plugin marketplace add kh-bikash/cutit
/plugin install cutit@cutit-marketplace
```

(A local folder also works the same way —
`/plugin marketplace add /path/to/cutit` — if you're testing a clone or a
fork before it's pushed.)

Once installed, every skill is available automatically (Claude Code
invokes them when relevant) and can also be called explicitly, namespaced
under the plugin: `/cutit:cutit`, `/cutit:cutit-frontend`,
`/cutit:cutit-parallel-delegation`, etc.

**Every skill installs at once.** Installing the plugin brings in all 112
skills together — there's no per-skill install through the marketplace.
Measured via `claude plugin details cutit@cutit-marketplace`, that's
**~10,220 tokens, always-on, in every session**, whether or not any of
them ever get invoked. If you'd rather cherry-pick, skip the plugin and
copy only the folders you want directly from
`plugins/cutit/skills/<name>/` into your own `.claude/skills/<name>/`
(project-level) or `~/.claude/skills/<name>/` (global) — see
[SWARM.md](SWARM.md) for the full list to choose from.

## Why this works

Agentic sessions spend tokens in three places: what gets read in, what
tools hand back, and what gets written out — including everything a
sub-agent has to re-derive from scratch because it started cold, or a
pipeline stage re-explains to the next one. The swarm targets all three
without touching how carefully the actual task gets done: every file ends
with a guardrail describing exactly when applying its cut would risk
correctness, and defers to spending the tokens in that case.
