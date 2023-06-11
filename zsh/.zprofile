#if [ "$OSTYPE" != linux-gnu ]; then  # macOS only:
#	eval "$(/opt/homebrew/bin/brew shellenv)"
#fi

#export PATH="/opt/homebrew/bin:/opt/homebrew/opt:/opt/homebrew/opt/openjdk/bin:$HOME/.local/bin:$HOME/.dotnet/tools:/usr/local/bin:$PATH"
export PATH="/opt/homebrew/opt/make/libexec/gnubin:/opt/homebrew/opt/openjdk/bin:$HOME/.local/bin:$HOME/.dotnet/tools:/usr/local/bin:$PATH"
export EDITOR="nvim"
export VISUAL="nvim"
export TERMINAL="alacritty"
export BROWSER="firefox"
export READER="zathura"
export MANWIDTH=120

# Start graphical server on tty1 if not already running.
if [ "$OSTYPE" = linux-gnu ]; then  # linux only:
	[ "$(tty)" = "/dev/tty1" ] && ! pgrep -x Xorg >/dev/null && exec startx
fi
