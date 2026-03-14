# Dotfiles

This repo is macOS-first.

Active packages live at the repo root and are the only packages installed by default via [install.sh](install.sh).

Current active packages:

- aerospace
- alacritty
- bash
- git
- zellij
- zsh

Archived configs live under [archive/linux](archive/linux) and [archive/legacy](archive/legacy).

- [archive/linux](archive/linux) contains old Linux desktop and helper configs kept as reference for a future Linux setup.
- [archive/legacy](archive/legacy) contains configs for tools no longer managed here, including tmux, old Vim/Neovim configs, and pre-AeroSpace macOS window manager configs.

System bootstrap is handled outside this repo.

- Homebrew and machine bootstrap live in a separate install-scripts repo.

Local-only config:

- `git/.gitconfig-work` stays ignored because it contains work identity details.

Tools intentionally not managed here right now:

- LazyVim / Neovim distribution setup

The install script focuses on the current active setup, not on restoring every historical machine this repo has ever supported.
