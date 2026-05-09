# Subagent delegation

**Read this before** spawning a subagent (Agent tool) or deciding whether to do mechanical work yourself.

## Delegation triggers — flip to a subagent when

- About to read >500 lines just to build context → delegate, ask for a <200-word digest.
- The same edit pattern repeats across files → fan out, even for 3 files.
- Running builds/tests and triaging output → subagent kicks off and categorises; you re-engage only for the fix decision.
- Searching/grepping and classifying call sites → subagent returns the digest.
- Writing boilerplate from a decided spec (tests, configs, CI YAML, docs mirroring code).
- Drafting commit messages or PR bodies from a known diff.
- The work is **investigation** rather than **decision** — investigation fans out, decisions stay with you.

Ask "would I be embarrassed to have Opus do this?" — if yes, delegate. If you can't articulate why Opus is needed, use Sonnet.

## Model selection

- **`sonnet`** — **default.** Well-scoped coding tasks, bulk repetitive changes, build/test runs, investigation, context-gathering, boilerplate generation, doc updates, PR/commit drafting.
- **`opus`** — reserve for complex reasoning, architectural decisions, novel problem-solving, and synthesising results from multiple Sonnet agents.
- **`haiku`** — monotonous tasks: file searches, mechanical find-and-replace, running builds/tests, and triaging failures (categorise, group, summarise). Hand off to `sonnet` for diagnosis and fix decisions.

## Default to parallel

Before starting any multi-step task, scan for independent workstreams. If two things don't depend on each other, run them in parallel — don't serialize. Recognition triggers:

- Multiple files/modules need the same kind of change
- Research across 2+ independent areas (repos, docs, APIs)
- A task has both investigation and implementation that can overlap
- Tests/builds can run while you continue editing
- Multiple independent subtasks in a plan
- Reading/exploring several unrelated parts of a codebase

## Worktree isolation

Prefer `isolation: "worktree"` when spawning subagents that edit files. This prevents concurrent agents from clobbering each other's changes. Solo sequential work can stay on master (the `/push` skill creates feature branches at push time).
