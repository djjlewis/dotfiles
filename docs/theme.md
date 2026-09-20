# Themes

`theme` recolours Ghostty, tmux, Starship, btop, and Neovim together.

| Command | Result |
| --- | --- |
| `theme` | Pick from a list with fzf |
| `theme list` | Print every theme with its label and whether it is light or dark |
| `theme set NAME` | Apply a theme |
| `theme show` | Print the theme in use |

tmux restyles every running session at once, and Starship follows the terminal
palette. Ghostty on macOS needs `Command+Shift+,` to reload. btop and Neovim
read their colours at startup, so restart them.

`install.sh` applies `catppuccin-macchiato` on a machine with no theme and
leaves an existing choice alone.

## Themes

Thirteen palettes ship in `theme/.config/dotfiles-theme/palettes`, with the
colours taken from Ghostty's bundled theme files.

| Family | Names |
| --- | --- |
| Catppuccin | `catppuccin-latte` (light), `catppuccin-frappe`, `catppuccin-macchiato`, `catppuccin-mocha` |
| Gruvbox | `gruvbox-dark-hard`, `gruvbox-dark`, `gruvbox-dark-soft`, `gruvbox-light-hard`, `gruvbox-light`, `gruvbox-light-soft` |
| Gruvbox Material | `gruvbox-material-dark`, `gruvbox-material-light` |
| Tokyo Night | `tokyo-night` |

## What each application reads

A palette file holds sixteen ANSI colours, a background, a foreground, a
cursor, two selection colours, and the Neovim plugin block for that theme.
`theme set` renders it four ways. Nothing generated lands in this repo, so
`git status` stays clean when you switch.

| Application | File it reads | How it gets the colours |
| --- | --- | --- |
| Ghostty | `~/.local/state/dotfiles-theme/ghostty.conf` | The full palette, included by the shared Ghostty config |
| tmux | The terminal palette, plus `~/.local/state/dotfiles-theme/tmux.conf` | The tmux config uses named colours. The generated file fixes only the two spots that draw text on top of the accent colour |
| Starship | The terminal palette | Named colours. Nothing is generated |
| btop | `~/.config/btop/themes/dotfiles-current.theme` | A generated btop theme. The btop config always points at this name |
| Neovim | `~/.config/nvim/lua/plugins/dotfiles-theme.lua` | A generated LazyVim spec that installs the matching colourscheme plugin |

To add a theme, copy a palette file, change the colours, and point the Neovim
block at a colourscheme plugin.

## Editors outside the terminal

VS Code and the JetBrains IDEs do not follow `theme`. Their settings belong to
Settings Sync, so set them by hand once per machine.

- VS Code: install `enkia.tokyo-night`, set `workbench.colorTheme` to
  "Tokyo Night", and set both `editor.fontFamily` and
  `terminal.integrated.fontFamily` to `JetBrainsMono Nerd Font` at 14 point.
  The integrated terminal needs its own font setting or Nerd Font glyphs
  render as boxes.
- JetBrains: a Tokyo Night plugin from the marketplace, `JetBrains Mono` at 14
  for the editor, and `JetBrainsMono Nerd Font` at 14 for the console. The
  shipped JetBrains Mono has no Nerd Font glyphs.
