# Omarchy parity backlog

What is still missing against Omarchy 4 (Quattro), checked in September 2026. What differs on purpose, and what will not
be ported, is in [differences from Omarchy](omarchy-differences.md).

## Shell

`sff` picks the most recently modified file and scps it. Omarchy's version uses `find -printf`, which is GNU-only, so it
needs rewriting around `fd` before it can be ported.

`try` manages date-stamped experiment directories. There is no Homebrew formula, so it means installing from source or
leaving it out.

## Runtimes

mise is installed and `ga` trusts a new worktree with it, but NVM still owns Node and `.zshrc` still loads it. Finishing
the move means pinning each project with `mise.toml` or `.tool-versions` as you touch it, then deleting the NVM block.
Nothing forces the order.

## Capture

Omarchy has three capture features macOS does not:

| Omarchy                                    | What it would take                                                                                                     |
| ------------------------------------------ | ---------------------------------------------------------------------------------------------------------------------- |
| `Super+Print Screen` colour picker         | Digital Color Meter ships with macOS but will not copy hex without a keystroke sequence. Shottr does both this and OCR |
| `Super+Ctrl+Print Screen` OCR to clipboard | Live Text reads a screenshot in Preview already, just not in one key                                                   |
| `Super+Ctrl+X` and `F9` dictation          | macOS dictation is built in. It only needs its shortcut set to F9 under System Settings, Keyboard, Dictation           |

Shottr was considered and left out. Screen-recording permission makes it a poor fit for a work machine.

## Toggles

`Super+Ctrl+N` toggles nightlight and `Super+Ctrl+I` toggles locking on idle. macOS has Night Shift and `caffeinate` but
no shortcut for either. Night Shift needs a third-party CLI. Idle lock could wrap `caffeinate -d` in a script the way
`remind` wraps `sleep`.

## CapsLock compose key

Omarchy turns CapsLock into a compose key, so `CapsLock M S` types an emoji and `CapsLock Space E` types your email
address. The completions map onto macOS Text Replacement, which syncs through iCloud. The emoji chords need
Karabiner-Elements, which installs a driver that sees every keystroke. That was considered and left out.

## Screenshot location

Omarchy saves screenshots to `~/Pictures`; macOS saves them to the Desktop.
`defaults write com.apple.screencapture location ~/Pictures` followed by `killall SystemUIServer` matches it. That is
two lines in a new `screenshots` group in `macos/defaults`, which now holds the rest of the system settings.

## App launchers

Omarchy binds Spotify and others under `Super+Shift`. The AeroSpace config follows the same pattern,
`exec-and-forget open -a Name`, and binds Firefox, Finder, Neovim, lazydocker and ChatGPT. Adding more is a line each,
once the apps are installed and in a Brewfile.
