# Local Environment

## Hardware / OS

MacBook Pro M4 Max, 128 GB unified memory, macOS 26 (Tahoe) arm64. **Before** planning local ML/inference, choosing model sizes, deciding what fits in memory, or making hardware-bound tradeoffs, read [`~/.claude/hardware.md`](~/.claude/hardware.md) for full specs and implications.

## Shell

zsh + Oh-My-Zsh + Powerlevel10k. **Before** editing any dotfile (`~/.zshrc`, `~/.zshenv`, `~/.zsh/*.zsh`, `~/.bashrc`, `~/.profile`), modifying aliases or shell functions, or troubleshooting shell startup behaviour, read [`~/.claude/shell-environment.md`](~/.claude/shell-environment.md) for the load order, modular config layout, alias table, and editing rules.

## Home Directory Backup

**yadm** manages dotfiles via a bare git repo over `$HOME`. Files are tracked in-place — edit live, then `yadm add`, `yadm commit`, `yadm push`. Remote: `marcelocantos/dotfiles`.

- A launchd job (`com.marcelocantos.yadm-auto-sync`) auto-commits and pushes modified tracked files every 30 minutes. Script: `~/.local/bin/yadm-auto-sync`. Log: `~/.local/var/log/yadm-auto-sync.log`.
- New files still require a manual `yadm add` — auto-sync only covers already-tracked files.
- When editing dotfiles in a session, `yadm add` new files immediately. Modified tracked files will sync automatically.
