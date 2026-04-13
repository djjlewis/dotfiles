export PATH="$HOME/.local/bin:$HOME/.dotnet/tools:/usr/local/bin:$PATH"

if [[ "$OSTYPE" == darwin* ]]; then
	export PATH="/opt/homebrew/opt/make/libexec/gnubin:/opt/homebrew/opt/openjdk/bin:$PATH"
fi

export EDITOR="nvim"
export VISUAL="nvim"
export TERMINAL="alacritty"
export BROWSER="firefox"
export READER="zathura"
export MANWIDTH=120

# Start graphical server on tty1 if not already running.
if [[ "$OSTYPE" == linux-gnu* ]]; then
	[ "$(tty)" = "/dev/tty1" ] && ! pgrep -x Xorg >/dev/null && exec startx
fi

# OrbStack — macOS-only container/VM tool
if [[ "$OSTYPE" == darwin* ]] && [ -f ~/.orbstack/shell/init.zsh ]; then
	source ~/.orbstack/shell/init.zsh
fi
