# Ghostty

Two config files. `ghostty/.config/ghostty/config` holds the layout and keys and is shared with Linux.
`ghostty-macos/Library/Application Support/com.mitchellh.ghostty/config` loads after it on macOS and holds the Mac
settings. Colours come from the [theme](theme.md) command.

Press `Command+Shift+,` after editing either file to reload.

## Look

JetBrainsMono Nerd Font at 14 point, 90% opacity, 14 pixels of padding, and a block cursor that does not blink. The
resize overlay is off.

## Keys

Ghostty's own Command keys work as normal. `Command+T` opens a tab, `Command+D` and `Command+Shift+D` split, `Command+W`
closes. These are the additions.

| Key                                    | Action                         |
| -------------------------------------- | ------------------------------ |
| `Ctrl+Shift+E`                         | Split below                    |
| `Ctrl+Shift+O`                         | Split beside                   |
| `Ctrl+Shift+T`                         | New tab                        |
| `Ctrl+Shift+Left` / `Ctrl+Shift+Right` | Previous or next tab           |
| `Shift+PageUp` / `Shift+PageDown`      | Scroll a page                  |
| `Command+Ctrl+Option+Shift+Arrow`      | Resize the split by 100 pixels |
| `Shift+Insert` / `Ctrl+Insert`         | Paste and copy                 |
| `Option+3`                             | Types `#`                      |

Option acts as Alt, so `Option+letter` reaches the shell and terminal apps as `Alt+letter`. That is what makes `Alt+C`
in fzf work. The cost is that `Option+letter` no longer types accented characters. `Option+3` gets its own binding
because the UK keyboard puts `#` there.

`Shift+Enter` and `Option+Shift+Enter` are sent as distinct key codes rather than plain Enter, so programs that support
it, such as Claude Code, can use them for a newline. Older programs may treat them as Enter.

## Closing

`Ctrl+D` on the last shell closes the window without a prompt, and closing the last window quits Ghostty.

## The `ghostty` command

`ghostty-macos` puts a `ghostty` wrapper in `~/.local/bin`, because the app's own binary only handles `+` actions on
macOS.

```bash
ghostty -e btop            # a new window running btop
ghostty +list-themes       # any + action goes to Ghostty's CLI
```

AeroSpace's launchers use the `-e` form.

## Terminal type

Ghostty sets `TERM` to `xterm-ghostty` locally. Its shell integration switches that to `xterm-256color` for ssh
sessions, since most servers do not have the Ghostty terminfo. Inside tmux, `TERM` is `tmux-256color`.
