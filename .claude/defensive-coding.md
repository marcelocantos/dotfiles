# Defensive coding gotchas

**Read this before** writing code that handles external input, propagates errors, traverses graph-shaped data, manipulates filesystem paths or URLs, or kills processes by port.

Write code with an awareness of what can go wrong. Think about trust boundaries (where does data come from?), failure modes (what if this call fails?), and termination (can this recurse or loop forever?).

## Common gotchas

- **Trust boundaries**: Data from external sources (user input, config files, network responses, manifests from other repos) must be validated before use. File paths must not escape their intended directory; URLs must be well-formed; indices must be in range.
- **Error propagation**: Never silently discard errors from I/O, OS, or network operations. Check and propagate — or explicitly document why a discard is safe.
- **Termination**: Recursive traversals over graph-like structures need cycle guards (a visited set). Unbounded retries need a limit.
- **Right primitive**: Use string operations for logical formats (URLs, URIs, protocol fields) and filepath operations for OS paths. Don't mix them.
- **Resource hygiene**: Preserve file attributes (permissions, ownership) when rewriting. Close/clean up resources on all paths, including errors.
- **Port cleanup**: When killing processes to free a port, only kill the process **listening** on that port (i.e. the server), not every process that has an open connection to it. `lsof -iTCP:<port> -sTCP:LISTEN -t` returns only listeners. Never use `lsof -ti:<port> | xargs kill` — that kills clients too (browsers, database connections, etc.).
