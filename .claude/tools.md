# Available Tools (Homebrew)

Notable tools installed via Homebrew that may be useful during development.

**WebSocket / Network testing:**
- `websocat` — WebSocket client/server CLI. Use for testing WebSocket endpoints (e.g. `websocat ws://localhost:42069/path`).
- `websocketd` — turn any CLI program into a WebSocket server.
- `grpcurl` — `curl` for gRPC services.
- `httpie` (`http`) — user-friendly HTTP client (aliased to `h` with `--check-status --follow`).
- `nmap` — network scanning and port discovery.

**C/C++ build tooling:**
- `cmake`, `ninja` — build system generators.
- `ccache` — compiler cache (speeds up rebuilds).
- `bear` — generates `compile_commands.json` from build commands (for clangd/LSP).
- `compiledb` — alternative `compile_commands.json` generator from make.
- `clang-format` — C/C++ code formatter.
- `include-what-you-use` — header dependency analysis.
- `conan` — C/C++ package manager (prefer vendoring per Dependencies policy, but available).

**Languages / Runtimes (beyond C++):**
- `go` (1.25), `rust`, `zig` (0.15), `node`, `ruby`, `kotlin`, `elixir`/`erlang`, `ocaml`, `lua`, `dotnet`.
- `emcc` (Emscripten) — compile C/C++ to WebAssembly.
- `uv` — fast Python package/project manager (see Python section in CLAUDE.md).

**VCS:**
- `jj` (Jujutsu) — Git-compatible VCS with simpler mental model. Available alongside `git`.
- `gh` — GitHub CLI.
- `difftastic` (`difft`) — syntax-aware structural diffs. Shows what changed semantically, not just line-by-line.

**Shell / File utilities:**
- `bat` — `cat` with syntax highlighting.
- `fd` — fast `find` alternative.
- `entr` — run commands when files change (e.g. `fd .cpp | entr make`).
- `tokei` — code statistics (lines of code by language).
- `dust` — disk usage visualiser.
- `parallel` — GNU parallel for parallelising shell commands.
- `shellcheck`, `shfmt` — shell script linting and formatting.
- `pandoc` — universal document converter.
- `hyperfine` — precise CLI benchmarking (e.g. `hyperfine 'make' 'make -B'`).
- `hexyl` — hex viewer for binary file inspection (mesh packs, wire protocol dumps, texture data).

**AI / ML (local):**
- `ollama` — run local LLMs. Use for testing AI integrations without API calls.
- `llama.cpp` — direct LLM inference engine.

**Media:**
- `ffmpeg` — audio/video transcoding and manipulation.
- `imagemagick` — image conversion and manipulation from CLI.

**JSON / Data:**
- `jq` — JSON processor (installed via zerobrew at `/opt/zerobrew/prefix/bin/jq`).
- `yq` — YAML/JSON/XML processor.

**Containers / Cloud:**
- OrbStack — Docker Desktop replacement (see Shell Startup Scripts in `~/CLAUDE.md`).
- `k9s`, `kubectl`, `skaffold` — Kubernetes management.
- `gcloud` — Google Cloud CLI.
- `qemu` — hardware virtualisation / emulation.
- `act` — run GitHub Actions locally. Test CI workflows without pushing.

**iOS device tooling:**

iOS devices have **two different identifiers** — don't confuse them:
- **Hardware UDID** (e.g. `00008103-...`): used by `xcodebuild`,
  `xcrun devicectl`, and `xcrun xctrace list devices`. This is what
  you pass to `-destination "id=..."`.
- **CoreDevice UUID** (e.g. `E1A01EA6-...`): used by
  `pymobiledevice3` and Apple's CoreDevice framework. Looks like a
  standard UUID. Discover with `pymobiledevice3 usbmux list`.

Device identifiers are documented per-device in the project's
`CLAUDE.md` (under iOS Testing) with both IDs labelled.

- `pymobiledevice3` — pure-Python CLI for interacting with iOS devices over USB or Wi-Fi. Installed in `~/.py`. Key commands:
  - **Screenshots**: `pymobiledevice3 developer screenshot /path/to/out.png` (deprecated API, still works) or `pymobiledevice3 developer dvt screenshot /path/to/out.png` (DVT API). For iOS 17+, append `--tunnel ''` to use tunneld.
  - **Syslog**: `pymobiledevice3 syslog` — live syslog stream with filtering.
  - **Apps**: `pymobiledevice3 apps list` — list/query/install/uninstall apps.
  - **Files**: `pymobiledevice3 afc` — browse/push/pull files in `/var/mobile/Media`.
  - **Process control**: `pymobiledevice3 developer dvt proclist`, `kill`, `launch`, `pkill`.
  - **Location simulation**: `pymobiledevice3 developer simulate-location` — set/clear/replay GPX routes.
  - **Network capture**: `pymobiledevice3 pcap` — sniff device traffic.
  - **Crash reports**: `pymobiledevice3 crash` — pull crash logs.
  - **Diagnostics**: `pymobiledevice3 diagnostics` — reboot, shutdown, battery/IO info.
  - **Backup**: `pymobiledevice3 backup2` — create/restore MobileBackup2 backups.
  - **System monitor**: `pymobiledevice3 developer dvt sysmon` — top-like monitoring.
  - **Energy**: `pymobiledevice3 developer dvt energy <PID>` — per-process energy consumption.
  - **WebInspector**: `pymobiledevice3 springboard` — UI interaction, orientation.
  - **Developer mode**: `pymobiledevice3 amfi` — enable/query developer mode; `pymobiledevice3 mounter mount` — mount DeveloperDiskImage (prerequisite for `developer` commands).
  - For iOS 17+, create a tunnel first: `sudo pymobiledevice3 remote start-tunnel`, then pass `--tunnel ''` to commands.

**Formal verification:**
- TLA+ (`tla2tools.jar`) — model checker for concurrent/distributed protocols. Projects that use it typically have a `formal/` directory with a `tlc` wrapper script.
