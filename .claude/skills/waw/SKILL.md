---
name: waw
description: "Where Are We?" — Context restoration after being AFK. Summarises session state, surfaces important details, and proposes continuation options.
user-invocable: true
---

**DELEGATE VIA CWORK.** Send `cwork` with task `"Read and execute
~/.claude/skills/waw/worker.md. Return the full briefing."` and
`model: opus`. Relay the worker's result to the user.

The worker gathers all context (git activity, targets, maintenance
status, etc.) and produces the briefing. The root session presents
it and handles any follow-up actions.
