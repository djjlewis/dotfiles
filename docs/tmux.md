# tmux

The prefix is `Ctrl+Space`. `Ctrl+B` works too. Config: `tmux/.config/tmux/tmux.conf`. Press prefix then `?` for the
full key list at any time.

The status line sits at the top. Windows and panes number from 1, and windows renumber when one closes. The mouse
selects panes and text. Closing the last window of a session switches to another session rather than detaching.

## Panes

| Key (after the prefix) | Action                           |
| ---------------------- | -------------------------------- |
| `%`, or the pipe key   | Split beside                     |
| `-` or `"`             | Split below                      |
| `h` `j` `k` `l`        | Focus left, down, up, right      |
| `H` `J` `K` `L`        | Resize by five cells. Repeatable |
| `x`                    | Kill the pane                    |

Without the prefix, `Ctrl+Option+Arrow` focuses a pane and `Ctrl+Option+Shift+Arrow` resizes it. New panes open in the
current directory.

## Windows and sessions

| Key (after the prefix) | Action                              |
| ---------------------- | ----------------------------------- |
| `c`                    | New window                          |
| `r`                    | Rename the window                   |
| `Ctrl+H` / `Ctrl+L`    | Previous or next window. Repeatable |
| `&`                    | Kill the window                     |
| `C`                    | New session                         |
| `R`                    | Rename the session                  |
| `N` / `P`              | Next or previous session            |
| `K`                    | Kill the session                    |
| `q`                    | Reload the config                   |

Windows name themselves after the current directory until renamed.

## Copy mode

Prefix then `[` enters copy mode with vi keys. `v` starts a selection, `y` copies it to the macOS clipboard and leaves
copy mode. Scrollback holds fifty thousand lines.

## Layouts

Four commands build a working layout for the current directory.

`tdl [agent]` is the everyday one. Outside tmux it creates or reattaches a `Dev-<directory>` session. Inside tmux it
opens a new window. Either way you get Neovim across the top, a shell along the bottom quarter, and a pane to the right
of the editor for an agent.

```bash
tdl            # editor, shell, empty agent pane
tdl codex      # the same with codex running in the agent pane
tdl --here     # build it in the current window instead of a new one
```

`tds [agent]` needs a running tmux and makes a two-by-two grid: Neovim, lazygit, a shell, and the agent pane.

`tdlm [agent]` runs `tdl` once per subdirectory of the current directory, one window each, and renames the session after
the directory. Past five subdirectories it asks first, since each one is three panes.

`tsl 4 'claude'` splits the window into four panes and runs the command in each.
