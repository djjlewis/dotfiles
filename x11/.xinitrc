setxkbmap -layout gb -option ctrl:nocaps
eval $(~/.local/bin/wallpaper &)
eval $(~/dual-screens.sh &)
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK # Think this was added because gnome-keyring expects it..?
xrdb -merge ~/.Xresources
redshift-gtk &
pcloud &
exec dbus-launch i3
