# TLA+ / Formal Verification

- **Always bound the state space.** Channels, queues, sets, and
  sequences that can grow without limit produce infinite (or
  astronomically large) state spaces. Every such structure in a TLA+
  model must have an explicit capacity bound — use model constants
  (e.g., `MaxQueueLen`, `MaxInFlight`) and constrain them in the
  config. Without bounds, TLC will explore forever or OOM.
- Choose the smallest bounds that still exercise the interesting
  behaviour. Start small (2–3) and increase only if the property
  requires it. State space grows combinatorially.
- Use `-workers auto` for exploration but be aware it will saturate
  all cores. Use `-workers 1` for deterministic, reproducible runs.
- When writing or reviewing a TLA+ spec, proactively check for
  unbounded growth: any variable that accumulates values across steps
  (append-only logs, growing sets, message channels) is a candidate
  for bounding.
- For a broader survey of verification tools beyond TLA+ (property-based
  testing, sanitizers, fuzzing, Jepsen, etc.) with a decision tree, see
  [`~/.claude/verification-tools.md`](~/.claude/verification-tools.md).
