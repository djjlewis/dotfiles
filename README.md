# Dotfiles

Cross-platform: macOS (primary) and Arch Linux (in a Parallels/UTM VM).

Active packages live at the repo root. [install.sh](install.sh) selects the right ones for the current OS.

## Active packages

| Package    | macOS | Linux | Notes |
|------------|:-----:|:-----:|-------|
| aerospace  |   ✓   |       | macOS tiling WM |
| alacritty  |   ✓   |   ✓   | TOML only (YAML format dead since v0.13) |
| bash       |   ✓   |   ✓   | Fallback shell |
| git        |   ✓   |   ✓   | Credential helper set per-OS in `.gitconfig-personal` |
| zellij     |   ✓   |   ✓   | |
| zsh        |   ✓   |   ✓   | OS-aware aliases; auto-startx on tty1 (Linux) |
| i3         |       |   ✓   | Tiling WM (gaps built-in since v4.22) |
| polybar    |       |   ✓   | Status bar |
| picom      |       |   ✓   | Compositor |
| rofi       |       |   ✓   | Launcher |
| dunst      |       |   ✓   | Notifications |
| x11        |       |   ✓   | `.xinitrc` + `.Xresources` |

## Window manager keys

- **AeroSpace:** workspaces are arranged into Personal (`P0`–`P9`) and Work
  (`W0`–`W9`) banks. Press `Option+;`, then `P` or `W` to change bank while keeping the same slot
  number. `Option+0`–`9` switches slots in the current bank and
  `Option+Shift+0`–`9` moves the focused window there. Slot 3 also uses Command
  (`Command+Option+3`, plus Shift to move) so AeroSpace does not swallow
  `Option+3` (`#` on a UK keyboard). To move across banks, press `Option+;`,
  then `Shift+P` or `Shift+W`, then the destination number. Toggle one window
  between floating and tiling with `Option+Shift+;`, then `F`.
- **i3:** the same numeric workspace and move pattern uses the Super key.
  `Super+Space` toggles the focused window between floating and tiling.

## Bootstrap

System-level bootstrap (Homebrew on macOS; Arch base + desktop stack on Linux)
is handled by a separate [os-install-scripts](https://github.com/djjlewis/os-install-scripts)
repo. That repo's `linux/post-install.sh` clones this one and runs `install.sh`.

## install.sh

- **macOS**: requires `stow` (install via `brew install stow`).
- **Linux (Debian/Ubuntu)**: installs `curl git npm ripgrep stow zsh zellij neovim`
  via apt; installs `diff-so-fancy` via npm; `starship` via curl|sh.
- **Linux (Arch)**: installs `curl git stow zsh ripgrep starship diff-so-fancy
  zellij neovim` via pacman.

## Local-only config

- `git/.gitconfig-personal` and `git/.gitconfig-work` stay ignored — they hold
  identity details and the OS-specific credential helper.

## Archived configs

- [archive/legacy](archive/legacy) — tmux, old Vim/Neovim, pre-AeroSpace macOS window managers.
- [archive/linux](archive/linux) — older Linux configs (compton-era i3, urxvt,
  multi-monitor scripts) kept for reference but no longer stowed.

## Not managed here

- LazyVim / Neovim distribution setup — bootstrapped by `os-install-scripts`'s
  `post-install.sh` (clones LazyVim starter into `~/.config/nvim`).
