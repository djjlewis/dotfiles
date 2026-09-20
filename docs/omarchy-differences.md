# Differences from Omarchy

This setup follows the [Omarchy manual](https://omarchy.org/manual) where macOS allows. This page lists every key and
command that had to change, and why, checked against Omarchy 4 (Quattro) in September 2026. The guides in this directory
describe what is here without reference to Omarchy. What is still missing is in the
[parity backlog](omarchy-parity-backlog.md).

## Super is Option

Omarchy hangs almost everything off Super. Here that role goes to Option, and Command keeps its macOS meaning. Read
every `Super` in the manual as `Option`.

Binding Command instead would capture shortcuts every app uses: `Command+T`, `Command+F`, `Command+W` and `Command+Q`,
`Command+1` to `8` for browser tabs and editor groups, `Command+Arrow` for caret movement, plus `Command+Tab` and
`Command+Space` for macOS itself.

Two consequences:

- On the UK keyboard, `Option+3` types `#`. Workspace 3 is `Command+Option+3` to switch and `Command+Option+Shift+3` to
  move.
- `Option+Arrow` is left unbound. macOS uses it to move the caret one word and `Option+Shift+Arrow` to select by word,
  in every text field and in readline. The vim-style keys do the same jobs.

## Window manager

[AeroSpace](https://nikitabobko.github.io/AeroSpace/) replaces Hyprland. The [AeroSpace guide](aerospace.md) has the
full key list.

| Omarchy                              | Here                                       | Why                                                    |
| ------------------------------------ | ------------------------------------------ | ------------------------------------------------------ |
| `Super+Arrow` focus                  | `Option+H/J/K/L`                           | Option+Arrow belongs to text editing                   |
| `Super+Shift+Arrow` swap             | `Option+Shift+H/J/K/L`                     | Same                                                   |
| `Super+Tab` next workspace           | `Option+Tab` returns to the previous one   | Predates the Omarchy work, kept                        |
| `Alt+Tab` cycle windows              | `Option+Ctrl+Tab`, `Option+Ctrl+Shift+Tab` | Option+Tab is taken by the line above                  |
| `Super+S` / `Super+Grave` scratchpad | `Option+Backtick` toggles workspace `S`    | AeroSpace has no dropdown workspace                    |
| `Super+Alt+S` move to scratchpad     | `Option+Shift+Backtick`                    | Same                                                   |
| `Super+1` to `0`                     | `Option+1` to `0` within the current bank  | See workspace banks below                              |
| `Super+Alt+Return` tmux terminal     | `Option+Ctrl+Enter`                        | Alt has no key left once Option plays Super            |
| `Super+Ctrl+Return` Herdr            | Unbound                                    | Herdr has no macOS package                             |
| `Super+Shift+Return` browser         | `Option+Shift+B`                           | `Option+Shift+Enter` is left for Ghostty's own binding |
| `Super+Shift+M` Spotify              | Unbound                                    | Not installed                                          |

Workspace banks are this repo's own idea. There are ten Personal workspaces and ten Work ones, and `Option+;` switches
between them while keeping the slot number. Moving a window to a slot does not follow it there.

No equivalent in AeroSpace: pseudo tiling (`Super+P`), sticky pop-out (`Super+O`), window grouping (`Super+G`), the
scrolling layout (`Super+L`), screen zoom (`Super+Ctrl+Z`), monitor scaling (`Super+/`) and the gaps toggle. Gaps are
fixed at 10 pixels.

## tmux

Omarchy's own tmux config is the starting point. The differences all come from keeping vim-style pane navigation on `h`,
`j`, `k` and `l`. The [tmux guide](tmux.md) has the full key list.

| Key                | Omarchy      | Here                                             |
| ------------------ | ------------ | ------------------------------------------------ |
| `h`                | Split below  | Focus pane left                                  |
| `v`                | Split beside | Unbound. Splits are the pipe key and `-`         |
| `j`, `l`           | Unbound      | Focus pane down, right                           |
| `k`                | Kill window  | Focus pane up. tmux's default `&` kills a window |
| `H`, `J`, `K`, `L` | Unbound      | Resize pane by five                              |

Omarchy's no-prefix Alt keys are mostly unavailable here. `Alt+Enter` opens Ghostty, `Alt+1` to `Alt+9` switch workspace
slots, and `Alt+Left/Right` move the caret by word. `Ctrl+Alt+Arrows` for pane focus and `Ctrl+Alt+Shift+Arrows` for
resize match Omarchy.

The `tds` layout runs lazygit in its diff pane. Omarchy runs `hunk diff --watch`, and hunk is an Omarchy tool. `tdl` is
a script rather than a function so it also works outside tmux, and takes one agent argument where Omarchy's takes two.
`tdlm` confirms past five subdirectories.

## Ghostty

The shared config is Omarchy's, minus the Linux-only `async-backend`. Ghostty binds its split and tab keys to Ctrl+Shift
on Linux and Command on macOS, so the Mac config adds the Ctrl+Shift keys back. The [Ghostty guide](ghostty.md) lists
them.

Two of the manual's Ghostty keys are not bound. `Ctrl+Alt+Arrows` goes to tmux pane focus, which matters more inside a
tmux session, and `Alt+1` to `9` goes to AeroSpace workspace slots.

## Shell

Omarchy's [shell tools](https://omarchy.org/manual/shell-tools/) and
[functions](https://omarchy.org/manual/shell-functions/) are ported to zsh in `zsh/.config/zsh/fns/`. Each file notes
its own differences. The [shell guide](shell.md) documents them.

| Function | Difference                                                                                                                  |
| -------- | --------------------------------------------------------------------------------------------------------------------------- |
| `gd`     | Checks the directory name before prompting, not after. Uses gum when installed, otherwise a plain prompt                    |
| `ga`     | Runs `mise trust` only when mise is installed                                                                               |
| `lip`    | Reads the command line from `ps`. BSD pgrep accepts `-a` and ignores it, so Omarchy's `pgrep -af` prints bare PIDs on macOS |
| `rsw`    | Watches with fswatch through `~/.local/bin/rsw-watch`. macOS has neither inotifywait nor `setsid`                           |
| `ssh`    | Names its argument array `ssh_args`. zsh reserves `argv` for the positional parameters                                      |

Omarchy aliases `cd` to a zoxide wrapper. Here `cd` stays `cd`, with `z` and `zi` for learned jumps. `o` runs `open .`,
standing in for Omarchy's `Super+Shift+Alt+F`.

## Themes

Omarchy picks a theme with `Super+Ctrl+Shift+Space` and re-themes the whole desktop. Here the [theme](theme.md) command
does it for the terminal stack only, and Ghostty on macOS needs a keypress to reload, since the macOS app does not
reload on SIGUSR2.

## Notices and reminders

`Option+Ctrl+R` sets a reminder, as Omarchy's `Super+Ctrl+R` does. Omarchy's notices are `Super+Ctrl+Alt+T/B/W`, which
cannot exist here because Option is already playing Super. Only weather has a key, `Option+Ctrl+Shift+W`. The menu bar
already shows the time and battery. The [macOS guide](macos.md) covers both commands.

## What macOS already does

These need no configuration. The manual's key is on the left.

| Omarchy                           | macOS                                            |
| --------------------------------- | ------------------------------------------------ |
| `Super+Space` menu                | `Command+Space` Spotlight                        |
| `Super+W` / `Super+Q` close       | `Command+W` / `Command+Q`                        |
| `Super+Ctrl+L` lock               | `Ctrl+Command+Q`                                 |
| `Super+Ctrl+E` emoji              | `Ctrl+Command+Space`                             |
| `Print Screen`                    | `Command+Shift+3` and `Command+Shift+4`          |
| `Alt+Print Screen` recording      | `Command+Shift+5`                                |
| `Super+Ctrl+Z` zoom               | Accessibility zoom                               |
| `Super+C/X/V` universal clipboard | `Command+C/X/V`, which already works in Terminal |

## Not ported

The top bar, dropdown panels, the Omarchy menu, shell plugins, web apps, the theme picker UI, gaming, the Windows VM and
system snapshots are Linux desktop components. macOS has its own menu bar, notification centre and Time Machine.

`iso2sd` and `format-drive` write to Linux block devices. The `hdl`, `hds`, `hdlm` and `hsl` functions drive herdr,
which has no macOS package.

Clipboard history, OCR capture and a colour picker have no macOS equivalent and no app installed by default. Maccy
covers clipboard history on the personal profile. The rest are in the [backlog](omarchy-parity-backlog.md).
