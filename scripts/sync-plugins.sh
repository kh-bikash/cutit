#!/usr/bin/env bash
# Regenerates the themed plugin bundles (cutit-agents, cutit-tooling,
# cutit-runtime, cutit-quality, cutit-domains) from the canonical skill
# source at plugins/cutit/skills/. That directory is the single source of
# truth for skill content — edit a skill there, then re-run this script to
# propagate the change into every themed plugin that bundles it.
set -euo pipefail
cd "$(dirname "$0")/.."

SRC="plugins/cutit/skills"

sync_group() {
  local plugin="$1"; shift
  local dest="plugins/$plugin/skills"
  mkdir -p "$dest"
  # Remove skill dirs no longer in this group, then repopulate.
  find "$dest" -mindepth 1 -maxdepth 1 -type d -exec rm -rf {} +
  for skill in "$@"; do
    cp -r "$SRC/$skill" "$dest/$skill"
  done
  echo "synced $plugin: $# skills"
}

sync_group cutit-core \
  cutit

sync_group cutit-agents \
  cutit-task-decomposition cutit-plan-revision cutit-goal-scoping cutit-step-sizing \
  cutit-plan-caching cutit-dependency-ordering cutit-early-termination cutit-checkpoint-planning \
  cutit-delegation-threshold cutit-context-handoff cutit-parallel-delegation cutit-agent-reuse \
  cutit-result-digestion cutit-orchestrator-lean cutit-fan-in-summarization cutit-spawn-avoidance \
  cutit-subagent-scoping \
  cutit-pipeline-stage-isolation cutit-handoff-summarization cutit-role-specialization \
  cutit-shared-state-store cutit-pipeline-short-circuit cutit-consensus-minimalism cutit-pipeline-caching

sync_group cutit-tooling \
  cutit-lazy-tool-loading cutit-tool-selection cutit-tool-result-capping cutit-tool-call-batching \
  cutit-tool-schema-pruning cutit-function-calling-minimalism cutit-tool-output-formatting cutit-retry-without-reload \
  cutit-chunk-sizing cutit-top-k-tuning cutit-rerank-before-stuff cutit-query-rewriting \
  cutit-retrieval-caching cutit-citation-scoping cutit-multi-hop-retrieval-budget \
  cutit-cache-aware-prompting cutit-few-shot-trimming cutit-system-prompt-diet cutit-dynamic-prompt-assembly \
  cutit-instruction-dedup cutit-template-reuse cutit-context-injection-scoping

sync_group cutit-runtime \
  cutit-context-budget-tracking cutit-proactive-compaction cutit-relevance-filtering cutit-memory-scoping \
  cutit-working-set-minimization cutit-stale-context-pruning cutit-rolling-summary cutit-scratchpad-offloading \
  cutit-selective-recall \
  cutit-session-resumability cutit-idle-agent-reuse cutit-background-task-batching \
  cutit-long-task-progress-compaction cutit-wakeup-scheduling cutit-multi-session-continuity \
  cutit-root-cause-first-retry cutit-partial-retry cutit-error-triage-budget cutit-backoff-without-context-bloat \
  cutit-known-failure-shortcuts cutit-graceful-degradation cutit-failure-scoped-logging \
  cutit-result-memoization cutit-cross-turn-dedup cutit-artifact-reuse cutit-prompt-cache-preservation \
  cutit-precomputed-index-reuse cutit-config-reuse \
  cutit-external-state-over-recap cutit-memory-write-discipline cutit-state-diffing cutit-todo-granularity \
  cutit-difficulty-based-routing cutit-escalation-on-failure cutit-batch-vs-realtime \
  cutit-breadth-vs-depth cutit-explore-then-commit cutit-negative-result-shortcut cutit-search-index-first \
  cutit-progressive-widening cutit-known-location-shortcuts cutit-search-result-triage

sync_group cutit-quality \
  cutit-cheap-precheck cutit-targeted-verification cutit-single-pass-confidence cutit-diff-verification \
  cutit-assertion-first cutit-incremental-validation cutit-golden-path-testing \
  cutit-clarify-before-commit cutit-confirmation-batching cutit-preference-capture \
  cutit-sampled-eval-review cutit-metric-first-triage cutit-cheap-guardrail-first cutit-fail-fast-guardrails \
  cutit-structured-output cutit-response-length-budgeting cutit-no-restate cutit-diff-only-output \
  cutit-summary-first cutit-terse-tool-narration

sync_group cutit-domains \
  cutit-frontend cutit-backend cutit-design

echo "all groups synced"
