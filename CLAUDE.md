# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build & Apply Commands

```bash
# Rebuild macOS system (nix-darwin + home-manager)
darwin-rebuild switch --flake ~/.dotfiles#lovemaker

# Or use the helper script (auto-detects OS)
./refresh.sh

# Update all flake inputs then rebuild
nix flake update && darwin-rebuild switch --flake ~/.dotfiles#lovemaker

# Linux (home-manager only)
home-manager switch --flake .
```

## Architecture

This is a Nix flakes-based dotfiles repo for macOS (nix-darwin) and Linux (home-manager).

**Core config files:**
- `flake.nix` — Flake inputs (nixpkgs, home-manager, nix-darwin, ghostty) and outputs. Defines `darwinConfigurations.lovemaker` for macOS and `homeConfigurations` for Linux/macOS standalone.
- `darwin.nix` — macOS system-level config: Homebrew casks/brews, keyboard remapping (Caps→Esc), key repeat speed, trackpad settings, primary user setup.
- `home.nix` — User-level config via Home Manager: packages, shell (zsh), editor (neovim), git, direnv, atuin. Uses `builtins.currentSystem` for platform detection (`isDarwin`). Symlinks app configs from this repo via `mkOutOfStoreSymlink`.

**Config flow:** `flake.nix` → `darwin.nix` (system) + `home.nix` (user) → symlinks to app config directories.

**App configs (symlinked into `~/.config/` or `~/`):**
- `nvim/` — Neovim (Packer, diffview)
- `aerospace/aerospace.toml` — AeroSpace window manager (macOS)
- `ghostty/config` — Ghostty terminal
- `cursor/keybindings.json` — Cursor IDE keybindings
- `mpv/` — MPV media player

**Homebrew packages** are declared in `darwin.nix` (not managed manually). Nix packages are declared in `home.nix`.
