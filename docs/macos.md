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

## Personal-profile apps

`brew/Brewfile.personal` adds two apps that fill gaps in macOS. Maccy keeps clipboard history and opens with
`Command+Shift+C`. LocalSend sends files to other machines on the network.
