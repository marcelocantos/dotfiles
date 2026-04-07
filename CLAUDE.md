# Hardware

MacBook Pro (Mac16,5) — Apple M4 Max, maximum spec (except storage).

| Component | Spec |
|-----------|------|
| **CPU** | M4 Max — 16 cores (12P + 4E) |
| **GPU** | 40-core Apple GPU, Metal 4 |
| **Neural Engine** | 16-core |
| **Memory** | 128 GB unified (546 GB/s bandwidth) |
| **Storage** | 2 TB APFS SSD |
| **Display** | 16" Liquid Retina XDR, 3456×2234 |
| **OS** | macOS 26 (Tahoe) arm64 |

**Implications for local ML/inference:**
- 128 GB unified memory can hold ~60B parameter models (Q4 quantised) entirely in memory — no GPU offloading needed since CPU and GPU share the same RAM.
- 546 GB/s memory bandwidth makes token generation fast for local LLMs.
- 40 GPU cores accelerate matrix operations (embedding generation, inference).
- For embedding workloads (~1M vectors at 768d): brute-force cosine search is feasible in-memory (~3 GB). sqlite-vec or HNSW index for sub-millisecond KNN.

# iOS Testing

**Pippa** (iPad Air 5th gen) is the preferred real device for testing iOS builds.
- **Hardware UDID** (for xcodebuild/devicectl): `00008103-000D39301A6A201E`
- **CoreDevice UUID** (for pymobiledevice3): `E1A01EA6-8D77-556C-B18D-D470B2909E87`

Use `xcrun xctrace list devices` to discover the hardware UDID; use `pymobiledevice3 usbmux list` for the CoreDevice UUID. These are different identifier systems for the same physical device.

# Shell Startup Scripts

Marcelo's shell is **zsh** with **Oh-My-Zsh** and **Powerlevel10k**.

## Load Order

1. **`~/.zshenv`** — Runs for every zsh (interactive & non-interactive).
   - Sources Cargo/Rust env (`~/.cargo/env`).
   - Sets `EDITOR=codewait`.

2. **`~/.zshrc`** — Interactive shells only.
   - Initialises Powerlevel10k instant prompt (must stay at top).
   - Loads Oh-My-Zsh with plugins: `git`, `fzf-tab`, `fzf-zsh-plugin`.
   - Sets `PROMPT_EOL_MARK` to a visible marker.
   - Sources the four modular config files (see below) via a loop.
   - Sources `~/.p10k.zsh` (Powerlevel10k theme config).
   - Activates global Python virtualenv from `~/.py/bin/activate`.

## Modular Config (`~/.zsh/`)

Sourced in this order by the loop in `.zshrc`:

| File | Purpose |
|---|---|
| `aliases.zsh` | Shell aliases (see table below) |
| `functions.zsh` | Custom functions: `pycat`, `cal`, `mcd` |
| `tools.zsh` | Tool integrations: iTerm2, you-should-use, jenv, pyenv (lazy), nvm (lazy), direnv, Docker Desktop, flyctl, `gg` repo-jumper |
| `completions.zsh` | Completions for fzf, Google Cloud SDK, bun, nvm |

## Aliases (`~/.zsh/aliases.zsh`)

| Alias | Target | Category |
|---|---|---|
| `eal` | `vi ~/.zsh/aliases.zsh` | Meta |
| `p` | `ipython3` | Python |
| `vi` | `nvim` | Editor |
| `m` | `make` | Build |
| `tig` | `tig --all` | Git |
| `mp` | `multipass` | VMs |
| `d` | `docker` | Docker |
| `dri` | `docker run -it --rm` | Docker |
| `dei` | `docker exec -it --rm` | Docker |
| `denvei` / `dkenv` | Envelope dev container helpers | Docker |
| `k` | `kubectl` | Kubernetes |
| `mk` | `minikube` | Kubernetes |
| `ls` | `eza --icons --git` | Files |
| `l` / `ll` | `ls -a` / `ls -al` | Files |
| `gmi` | `go mod init` (derives module from cwd) | Go |
| `gmt` | `go mod tidy` | Go |
| `gap` | `ga -p` (git add --patch) | Git |
| `gs` | `git status --short --branch` | Git |
| `ghs` | `/opt/homebrew/bin/gs` (GhostScript) | Git (workaround) |
| `gpu` | `git push -u origin @` | Git |
| `grup` | `git remote update -p` | Git |
| `h` | `http --check-status --follow` | HTTP |

Unaliased at the end: `g`, `la`, `lsa`, `gg` (clears Oh-My-Zsh defaults).

## Custom Functions (`~/.zsh/functions.zsh`)

- **`pycat <file>`** — Pretty-print a Python pickle file.
- **`cal [args]`** — Wraps `/usr/bin/cal` with colour highlighting for today; defaults to `-3` (three-month view).
- **`mcd <dir>`** — `mkdir` + `cd` in one step.

## Bash (`~/.bashrc`, `~/.profile`)

Minimal — only used as a fallback. Sources Cargo env, fzf, and Docker Desktop init.

## Environment Notes

- **OrbStack** is installed as a drop-in replacement for Docker Desktop. The `docker` CLI works as normal. Use this context where appropriate (e.g., OrbStack-managed Linux machines, lighter resource footprint). The `orb` CLI may offer useful OrbStack-specific commands beyond what `docker` provides.

## PDF Conversion

Prefer `mpe2pdf` (Markdown Preview Enhanced → PDF via Prince) over `pandoc`.
It produces output matching VS Code Markdown Preview Enhanced styling.

```bash
mpe2pdf input.md -o output.pdf
```

Fall back to `pandoc input.md -o output.pdf` only if `mpe2pdf` is unavailable.

## Home Directory Backup

**yadm** manages dotfiles via a bare git repo over `$HOME`. Files are tracked in-place — edit live, then `yadm add`, `yadm commit`, `yadm push`. No source/target split. Remote: `marcelocantos/dotfiles`.

- A launchd job (`com.marcelocantos.yadm-auto-sync`) auto-commits and pushes modified tracked files every 30 minutes. Script: `~/.local/bin/yadm-auto-sync`. Log: `~/.local/var/log/yadm-auto-sync.log`.
- New files still require a manual `yadm add` — auto-sync only covers already-tracked files.
- When editing dotfiles in a session, `yadm add` new files immediately. Modified tracked files will sync automatically.

## Editing Guidelines

- When editing aliases, edit **`~/.zsh/aliases.zsh`**, not `.zshrc`.
- When editing functions, edit **`~/.zsh/functions.zsh`**.
- When adding/removing tool integrations, edit **`~/.zsh/tools.zsh`**.
- When adding/removing completions, edit **`~/.zsh/completions.zsh`**.
- Keep `.zshrc` as a thin orchestrator; put content in the modular files.
