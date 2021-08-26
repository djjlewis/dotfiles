setxkbmap -layout gb -option ctrl:nocaps
eval $(~/.local/bin/wallpaper &)
xrdb -merge ~/.Xresources
redshift-gtk &
exec dbus-launch i3
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK
