# Dotfiles

GNU Stow packages for a macOS setup modelled on [Omarchy](https://omarchy.org): AeroSpace for tiling, Ghostty, tmux, zsh
with Omarchy's shell tools, LazyVim, and a `theme` command that recolours the terminal stack. Linux gets the shared
shell packages only, and has not been tested since the move to Omarchy.

## Install

On a new Mac, install [Homebrew](https://brew.sh), clone this repo, and run the installer once with a profile:

```bash
./install.sh --profile personal   # personal Mac
./install.sh --profile work       # work Mac, or just ./install.sh
```

The script:

- Installs [brew/Brewfile](brew/Brewfile) with `brew bundle`, then the package groups the profile selects. See
  [Package groups](#package-groups).
- Stows the packages below into your home directory. Any file already in the way is moved to
  `~/.dotfiles-backup-<timestamp>` first.
- Removes symlinks left behind by packages this repo no longer manages.
- Applies the `catppuccin-macchiato` theme if the machine has no theme yet.
- Runs [macos/defaults](macos/defaults) on macOS, which sets the Finder, keyboard and pointer settings. It changes
  preferences only and deletes nothing. `--no-defaults` skips it, and [the macOS guide](docs/macos.md) covers the
  groups it leaves for you to run.

The profile is saved to `~/.config/dotfiles/profile`, so later runs need no arguments. `--no-brew` stows the configs
without touching packages. On Linux the script stows the shared packages and installs the shell toolchain with pacman or
apt.

## Package groups

[brew/Brewfile](brew/Brewfile) is the core list every Mac gets. It holds what the stowed configs need, plus the shell
tools and TUIs from [Omarchy's base package list](https://github.com/omacom/omarchy/blob/quattro/install/omarchy-base.packages).
Docker, ImageMagick and ffmpeg are in core for the same reason: Omarchy installs them by default, and `lazydocker` in
core needs an engine to talk to.

Everything else is a group, installed on top of core.

| Group                              | Contents                                                       | work  | personal |
| ---------------------------------- | -------------------------------------------------------------- | :---: | :------: |
| [apps](brew/Brewfile.apps)         | ChatGPT, Tailscale                                             |   ✓   |    ✓     |
| [dev](brew/Brewfile.dev)           | Build tools, diagrams, coding agents, VS Code, Toolbox, Chrome |   ✓   |    ✓     |
| [cloud](brew/Brewfile.cloud)       | Azure CLI, azd, .NET SDK, Edge                                 |   ✓   |          |
| [office](brew/Brewfile.office)     | Microsoft Office, Teams, 365 Copilot                           |   ✓   |          |
| [media](brew/Brewfile.media)       | BlackHole 2ch and 16ch                                         |       |    ✓     |
| [vm](brew/Brewfile.vm)             | UTM                                                            |       |    ✓     |
| [games](brew/Brewfile.games)       | Steam                                                          |       |    ✓     |
| [personal](brew/Brewfile.personal) | Maccy, LocalSend, ProtonVPN                                    |       |    ✓     |

To pick groups for one run instead of taking the profile's preset:

```bash
./install.sh --groups dev,cloud
./install.sh --groups ''          # core only
```

One group on its own, without running the installer:

```bash
brew bundle --file brew/Brewfile.media
```

Firefox is the default browser and lives in core, because the AeroSpace config binds it. Chrome is in `dev` and Edge is
in `cloud`. Neovim is the editor in core, which is why VS Code and JetBrains Toolbox are a group rather than core.

## Guides

| Guide                          | Covers                                                              |
| ------------------------------ | ------------------------------------------------------------------- |
| [macOS](docs/macos.md)         | System settings, Finder layout, panel keys, reminders, notices      |
| [AeroSpace](docs/aerospace.md) | Window, workspace and launcher keys                                 |
| [Ghostty](docs/ghostty.md)     | Terminal keys, font, and the `ghostty` launcher                     |
| [Shell](docs/shell.md)         | zsh aliases, fzf, zoxide, and the worktree, ssh and rsync functions |
| [tmux](docs/tmux.md)           | Prefix keys and the `tdl`, `tds`, `tdlm` and `tsl` layouts          |
| [Neovim](docs/neovim.md)       | LazyVim and the markdown setup                                      |
| [Themes](docs/theme.md)        | The `theme` command and how to add a palette                        |
| [Security](docs/security.md)   | The `security-check` command and SSH over Tailscale                 |

The setup follows the [Omarchy manual](https://omarchy.org/manual) where macOS allows.
[Differences from Omarchy](docs/omarchy-differences.md) lists every key and command that had to change, and the
[parity backlog](docs/omarchy-parity-backlog.md) lists what is still missing.

## Packages

| Package       | macOS | Linux | Notes                                                              |
| ------------- | :---: | :---: | ------------------------------------------------------------------ |
| aerospace     |   ✓   |       | Tiling window manager config and the workspace bank script         |
| bash          |   ✓   |   ✓   | Fallback shell                                                     |
| btop          |   ✓   |       | Points at the theme the `theme` command writes                     |
| ghostty       |   ✓   |   ✓   | Layout and keys shared with Linux                                  |
| ghostty-macos |   ✓   |       | Mac font size, opacity, Option key, extra keys, and the launcher   |
| git           |   ✓   |   ✓   | Aliases and diff-so-fancy. Identity lives in ignored include files |
| mac-bin       |   ✓   |       | `remind`, `notice` and `security-check`                            |
| nvim          |   ✓   |       | LazyVim starter with the markdown extra                            |
| starship      |   ✓   |   ✓   | Prompt, coloured from the terminal palette                         |
| theme         |   ✓   |       | Colour palettes and the `theme` command                            |
| tmux          |   ✓   |   ✓   | Config and the `tdl` layout script                                 |
| zsh           |   ✓   |   ✓   | Aliases and the shell functions in `.config/zsh/fns`               |

Everything is stowed with `--no-folding`, because four packages put files in `~/.local/bin` and the `theme` command
writes into `~/.config/btop/themes` and `~/.config/nvim`. Folded, stow would link a whole directory at one package and
hide the rest, and the generated Neovim theme spec would land in this repo.

`theme` is macOS-only for now. On Omarchy it would write a colourscheme into Omarchy's own Neovim config.

## Staying in sync with Omarchy

The shell functions are ports, not copies. Omarchy's shell is bash and this one is zsh, so some of its functions
misbehave when sourced unchanged: bash arrays start at 0 and zsh's at 1, zsh reserves `argv`, and Omarchy's alias file
replaces `open` with `xdg-open`, which breaks it on macOS.

`scripts/omarchy-baseline` holds the verbatim upstream files each local version was written from. To see what Omarchy
has changed since:

```bash
./scripts/check-omarchy-drift           # list files that moved
./scripts/check-omarchy-drift --diff    # show what changed
./scripts/check-omarchy-drift --accept  # record upstream as the new baseline
```

Accept only after deciding whether the local file needs the same change. `scripts/omarchy-tracked.txt` maps each
upstream file to its local equivalent, and is the place to add another.

## Local-only config

`git/.gitconfig-personal` and `git/.gitconfig-work` stay ignored. They hold identity details and the OS-specific
credential helper.

## Archived configs

[archive/legacy](archive/legacy) has Zellij, old Vim and Neovim configs, and older macOS window managers.
[archive/linux/i3-desktop](archive/linux/i3-desktop) has the X11 desktop Linux used before Omarchy: Alacritty, i3,
polybar, picom, rofi, dunst and X11. None of it is stowed.

## Agent guidance

[AGENTS.md](AGENTS.md) has repo-specific instructions. The [unslop writing skill](.agents/skills/unslop/SKILL.md) is
stored in this repo and shared with Claude through symlinks.
