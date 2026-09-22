# macOS

The system-level keys and commands. The keys are AeroSpace bindings, so they work anywhere once AeroSpace is running.
The commands live in `mac-bin/.local/bin`.

## Settings panels

| Key             | Opens              |
| --------------- | ------------------ |
| `Option+Ctrl+A` | Sound settings     |
| `Option+Ctrl+B` | Bluetooth settings |
| `Option+Ctrl+W` | Wi-Fi settings     |
| `Option+Ctrl+D` | Display settings   |
| `Option+Ctrl+P` | Battery settings   |
| `Option+Ctrl+Q` | Calculator         |

## Reminders

`Option+Ctrl+R` asks for a duration and a message, then notifies you when the time is up. The same thing from a shell:

```bash
remind 5m 'Tea ready'    # seconds, or a number with s, m or h
remind list
remind clear
```

## Notices

`Option+Ctrl+Shift+W` shows the weather for your current location as a notification. From a shell, `notice weather`,
`notice time` and `notice battery` do the same for each. Set `WEATHER_LOCATION` to a place name to skip the IP lookup.

## Notifications

Both commands notify through terminal-notifier, which the Brewfile installs. The first notification asks whether to
allow it. If nothing appears, check System Settings, Notifications, terminal-notifier, and check that a Focus mode is
not hiding it.

## System settings

`macos/defaults` writes the settings this setup expects. `install.sh` runs it with no arguments, which applies three
groups.

| Group      | Changes                                                                                  |
| ---------- | ---------------------------------------------------------------------------------------- |
| `finder`   | List view, folders above files, path and status bars, visible file extensions            |
| `keyboard` | F1 to F12 as function keys, fast key repeat, held keys repeat, tab through every control |
| `pointer`  | Pointer speed                                                                            |

Four more groups stay manual, because each one changes something a machine may want left alone:

```bash
./macos/defaults dock      # auto-hide with no reveal delay
./macos/defaults text      # autocorrect and smart quotes, dashes, capitals and periods off
./macos/defaults hidden    # show hidden files in Finder
./macos/defaults scroll    # traditional scrolling, so natural scrolling off
```

`./macos/defaults --list` prints the same table. `./macos/defaults --backup` exports the domains the script writes into
`~/.dotfiles-backup-<timestamp>/defaults`, and prints the `defaults import` line that puts one back.
`./install.sh --no-defaults` stows the configs and leaves every system setting alone.

## Finder windows

The `finder` group gives every window the same layout: list view, folders above files, sorted by name, with name, date
modified and size columns. The columns add up to 450 points, which is what fits once AeroSpace has tiled the window to
half a screen and the sidebar has taken its share. Change the widths in the `list_view_template` function in
`macos/defaults`.

A folder Finder has already shown does not pick this up. Finder writes that folder's own view, sort order and column
widths into a `.DS_Store` file inside it, and that file wins over every preference above. Neither `install.sh` nor
`macos/defaults` deletes one. To drop the records and put every folder back on the shared layout:

```bash
./macos/defaults --reset-folder-views
```

It counts the `.DS_Store` files under your home directory, asks before deleting them, and restarts Finder. Folders lose
the window position, icon arrangement and column widths Finder recorded for them. Finder writes a fresh `.DS_Store` the
next time it shows a folder, so this stops nothing from being remembered again. Nothing outside your home directory is
touched, so external and network volumes keep their records.

## Personal-profile apps

`brew/Brewfile.personal` adds Maccy, LocalSend and ProtonVPN. The first two fill gaps in macOS: Maccy keeps clipboard
history and opens with `Command+Shift+C`, and LocalSend sends files to other machines on the network.
