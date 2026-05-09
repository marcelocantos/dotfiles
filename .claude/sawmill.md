# Sawmill (structural code edits)

**Read this before** renaming a symbol, finding callers/references, migrating an API across files, adding/removing function parameters, promoting constants, codegen, or auditing conventions/invariants.

**HARD RULE — try Sawmill first for code-shaped operations.** Sawmill is an MCP server that performs AST-level transforms across a codebase. Its primary purpose is to **save tokens and time** by letting you express a structural intent once instead of reading every file and emitting Edit calls for each one. Even when the text-shaped path (Read + Grep + Edit) would also work, prefer Sawmill — that is the bias being established.

## Triggers — reach for Sawmill when

- Renaming a symbol (function, type, variable, file) — `mcp__sawmill__rename` / `rename_file`
- Finding callers, references, or definitions — `find_references` / `find_symbol` / `definition` / `lsp_references`
- Migrating an API or pattern across files — `migrate_pattern` / `migrate_type` / `transform` / `transform_batch`
- Adding, removing, or changing a function parameter — `add_parameter` / `remove_parameter`
- Promoting a literal to a constant or moving config to env — `promote_constant` / `extract_to_env`
- Codegen from a spec, or applying a learned recipe — `codegen` / `apply` / `instantiate` / `clone_and_adapt`
- Querying structure (definitions, hovers, diagnostics) — `query` / `hover` / `diagnostics` / `parse`
- Auditing conventions or invariants — `check_conventions` / `check_invariants` / `check_equivalences`

## When to fall back to Read/Edit/Grep

- Single-file, single-site edits where the structural detour is pure overhead
- Prose, config, or markdown (Sawmill is for code)
- Languages or constructs Sawmill doesn't understand — try once; if `parse` or `find_symbol` fails, fall back

## Honest framing

The user is not 100% sold on Sawmill's utility — modern models manipulate text-form code well, so structural tooling may be redundant. The point of the aggressive trigger is to **give it a fair shake**: actually use it on real tasks, then judge from evidence. If after a sustained trial it isn't paying off in tokens, speed, or correctness, surface that and we'll retire it.
