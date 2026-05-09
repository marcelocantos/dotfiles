# Gates

**Read this before** running `/push`, `/release`, `/cv go`, `/republish-skills`, or any other skill that crosses a delivery boundary (merge, release, deploy).

Gates are checkpoints that must be satisfied before crossing delivery boundaries. They prevent the agent from bypassing established SDLC processes.

## Configuration

- Gate profiles live in `~/.claude/gates/`. Each profile extends `base.yaml` (or overrides specific base gates).
- Projects declare their profile in CLAUDE.md:
  ```
  ## Gates
  profile: game
  ```
- If no `## Gates` section exists, `base` gates apply by default.
- The agent reads `base.yaml` + the profile YAML and merges them. Profile gates add to base gates; `override: [gate: skip]` removes specific base gates.
- Available profiles: `base`, `game`, `library`, `cli`, `skill`.

## Gate types

- `automated` — agent checks itself (CI green, tests exist).
- `routed` — agent delegates to a skill (`/push`, `/release`).
- `manual` — agent pauses and asks the user to confirm. **The agent must never proceed past a manual gate without explicit user approval.**

## Enforcement

- Skills that cross delivery boundaries must check and enforce the project's gates before proceeding.
- `/cv` must never suggest raw delivery actions — always route through the appropriate skill.

## User override

Gates constrain the agent, not the user. If the user explicitly asks to skip a gate, honour that — but name the gate being skipped so the decision is conscious, not accidental. After a skip, offer to create a target to resolve the underlying issue (e.g., "🎯 CI is configured and green for this project").
