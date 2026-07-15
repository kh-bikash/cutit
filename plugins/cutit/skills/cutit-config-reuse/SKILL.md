---
name: cutit-config-reuse
description: Catches re-querying environment or configuration facts (package manager, framework version, working directory, env vars) at every step of a task when the session already established them earlier. Invoke before any step that would re-check a fact already confirmed this session.
---

# cutit-config-reuse

Checking "what package manager does this project use" or "what's the current branch" once is diligence; checking it again at every subsequent step because the step is written as if starting fresh is pure repetition. These facts don't change mid-task, so re-querying them re-pays a lookup cost for information already sitting in context.

## Protocol

- Once a config/environment fact is established this session (package manager, language version, working directory, active branch, resolved env var), carry it forward and reference it instead of re-deriving it per step.
- Note resolved facts explicitly when they're first discovered (in a short internal note or the task tracker) so later steps can look them up instead of re-running the same discovery command.
- Before running a discovery command (`cat package.json`, `git branch`, `which python`), check whether this session already answered that exact question.
- Scope reuse to the fact's actual lifetime — a working directory or branch can change mid-session (a `cd`, a checkout); re-verify after any action that could have changed it, not on a fixed schedule.
- When delegating a subtask to another agent/step, pass along the already-resolved facts it needs rather than making it re-discover them cold.

## When not to cut

If an action in between could plausibly have changed the fact (a branch switch, a dependency install, a directory change), re-check before trusting the cached value — silently operating on a stale environment fact produces wrong results in a way that's hard to notice later.
