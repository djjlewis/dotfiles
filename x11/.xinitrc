#!/bin/sh
# ~/.xinitrc — started by `startx`. Triggered automatically on tty1 login
# via .zprofile. Keep this file minimal — most autostart belongs in i3 itself.

# Keyboard layout (UK with caps→ctrl). Comment out if not what you want.
setxkbmap -layout gb -option ctrl:nocaps

# Merge X resources if present (colour scheme for legacy X apps)
[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources

# Hand off to i3. Compositor / dunst / nm-applet / polybar are launched from
# inside the i3 config so they restart with i3.
exec i3
