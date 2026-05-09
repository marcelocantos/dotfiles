# Fan-out PR discipline (HARD RULE)

**Read this before** spawning multiple subagents in parallel that will edit code, or before letting any spawned agent push or open a PR.

## Rule: spawned subagents must NOT push or open PRs

When an agent is spawned by another agent — by `/cv` fan-out, by an orchestrating skill, by a parent Agent call, or by any other delegation — the spawned agent's terminal action is **`git commit` on its worktree branch, then stop**. It does not run `git push`, does not run `/push`, does not call `gh pr create`, and does not invoke any skill that would do those things. The branch sits locally for the parent to assemble.

This OVERRIDES the "pushing and opening a PR are pre-authorised" clause in `~/.claude/CLAUDE.md` for spawned agents specifically. The pre-authorisation applies to the *outermost* agent (the one talking to the user), not to the fan-out leaves.

**Why**: every spawned agent that opens its own PR turns a single fan-out into N concurrent PRs that all need separate review, separate gate enforcement, and manual reassembly when their changes overlap. The user has been burned by this pattern repeatedly. One PR per logical unit of work, assembled locally by the parent, is the only path that keeps review tractable.

## Orchestrator's responsibility after fan-out completes

1. Inspect each spawned agent's worktree branch (commits, diffs, what was claimed vs. what landed).
2. Decide whether to keep / squash / drop / re-order them. An agent that diverged from its brief or scope-crept gets its commits dropped or rewritten before assembly, not merged as-is.
3. Cherry-pick or merge the kept commits into a single integration branch off `master` (name it `<scope>-<date>` or `cv-fanout-<date>` — descriptive, not the agent IDs).
4. Resolve conflicts locally (much cheaper than resolving them across N PRs after the fact).
5. Run the project's `bullseye` / lint / test gates once on the integration branch.
6. `gh pr create` exactly **one** PR with a body that names every target / change folded in.
7. Clean up the worktrees and per-agent branches once the PR is up.

## Spawn-prompt hygiene

When writing prompts for spawned agents, include an explicit instruction equivalent to "commit to your worktree branch and stop — do NOT push, do NOT run /push, do NOT open a PR; the parent will assemble". Do not also tell the agent the push/PR steps are "pre-authorised" — that contradicts the rule and the agent will follow the more permissive instruction.

## Exception — single-agent delegation for a self-contained task

If a parent spawns *one* agent to do a complete, independent piece of work (not part of a fan-out, not part of a multi-agent scheme), the agent MAY open its own PR. The rule targets fan-outs and orchestrated multi-agent runs specifically. When in doubt, default to "commit and stop" — the parent can always run `/push` itself in one extra step.
