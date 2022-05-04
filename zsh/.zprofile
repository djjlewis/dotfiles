if [ "$OSTYPE" != linux-gnu ]; then  # macOS only:
	eval "$(/opt/homebrew/bin/brew shellenv)"
fi

export PATH="/opt/homebrew/opt/openjdk/bin:$PATH:$HOME/.local/bin;/Users/dan/.dotnet/tools"
export EDITOR="nvim"
export VISUAL="nvim"
export TERMINAL="alacritty"
export BROWSER="firefox"
export READER="zathura"

# Start graphical server on tty1 if not already running.
if [ "$OSTYPE" = linux-gnu ]; then  # linux only:
	[ "$(tty)" = "/dev/tty1" ] && ! pgrep -x Xorg >/dev/null && exec startx
fi
