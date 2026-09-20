# AeroSpace

[AeroSpace](https://nikitabobko.github.io/AeroSpace/) tiles windows. Every key
below uses Option, so Command keeps its macOS meaning. Config:
`aerospace/.config/aerospace/aerospace.toml`.

AeroSpace does not start at login. Open it from Spotlight once and it stays
running. `Option+Shift+;` then `Esc` reloads the config after an edit.

## Windows

| Key | Action |
| --- | --- |
| `Option+H/J/K/L` | Focus the window in that direction. At the edge of the screen, focus moves to the next monitor |
| `Option+Shift+H/J/K/L` | Move the window in that direction |
| `Option+Ctrl+H/J/K/L` | Focus the monitor in that direction |
| `Option+Ctrl+Shift+H/J/K/L` | Move the window to that monitor and follow it |
| `Option+-` / `Option+=` | Shrink or grow the window |
| `Option+T` | Toggle floating |
| `Option+F` | Toggle fullscreen |
| `Option+/` | Tiles layout. Press again to flip horizontal and vertical |
| `Option+,` | Accordion layout. Press again to flip |
| `Option+Ctrl+Tab` / `Option+Ctrl+Shift+Tab` | Cycle through the windows on this workspace |

`Option+Arrow` is left free. macOS uses it to move the caret by word in every
text field.

## Workspaces

There are two banks of ten workspaces, Personal `P0` to `P9` and Work `W0` to
`W9`, plus a scratchpad workspace `S`.

| Key | Action |
| --- | --- |
| `Option+1` to `Option+0` | Switch to that slot in the current bank |
| `Command+Option+3` | Slot 3. `Option+3` types `#` on a UK keyboard |
| `Option+Shift+1` to `Option+Shift+0` | Move the window to that slot. Focus stays where it is |
| `Command+Option+Shift+3` | Move to slot 3 |
| `Option+Tab` | Back to the previous workspace |
| `Option+Shift+Tab` | Move this workspace to the next monitor |
| `Option+;` then `P` or `W` | Switch bank, keeping the slot number |
| `Option+;` then `Shift+P` or `Shift+W`, then a digit | Move the window to that slot in the other bank |
| `` Option+` `` | Toggle the scratchpad workspace |
| `` Option+Shift+` `` | Move the window to the scratchpad |

`Esc` leaves the bank mode without doing anything.

New windows land in a fixed workspace for three apps: Ghostty in `W0`, Firefox
in `P1`, and ChatGPT in `W4`. Add a rule with an `on-window-detected` block.
`aerospace list-apps` prints the app IDs.

## Launchers

| Key | Opens |
| --- | --- |
| `Option+Enter` | A new Ghostty window |
| `Option+Ctrl+Enter` | Ghostty attached to the `Work` tmux session |
| `Option+Ctrl+T` | btop in Ghostty |
| `Option+Shift+N` | Neovim in Ghostty |
| `Option+Shift+D` | lazydocker in Ghostty |
| `Option+Shift+B` | Firefox |
| `Option+Shift+F` | Finder |
| `Option+Shift+A` | ChatGPT |

The keys that open System Settings panels, reminders and notices are in the
[macOS guide](macos.md).

## Service mode

`Option+Shift+;` enters service mode. The next key runs one command and
returns to normal.

| Key | Action |
| --- | --- |
| `Esc` | Reload the config |
| `R` | Flatten the layout tree |
| `F` | Toggle floating, for apps that swallow `Option+F` |
| `Backspace` | Close every other window on the workspace |
| `Option+Shift+H/J/K/L` | Join the window with its neighbour in that direction |
| `Up` / `Down` | Volume up or down |
| `Shift+Down` | Mute |

## Gaps and layout

Gaps are 10 pixels inside and out. New workspaces start as tiles, laid out
horizontally on a wide monitor and vertically on a tall one. Nested containers
are flattened, so a window never ends up two levels deep.
