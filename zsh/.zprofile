export PATH="$HOME/.local/bin:$HOME/.dotnet/tools:/usr/local/bin:$PATH"

# Docker Desktop's CLI shims. Docker Desktop appends this block itself with an
# absolute path; keep it relative to $HOME so the file stays portable.
if [ -d "$HOME/.docker/bin" ]; then
	export PATH="$PATH:$HOME/.docker/bin"
fi

if [[ "$OSTYPE" == darwin* ]]; then
	export PATH="/opt/homebrew/opt/make/libexec/gnubin:/opt/homebrew/opt/openjdk/bin:$PATH"
fi

export EDITOR="nvim"
export VISUAL="nvim"
if command -v ghostty >/dev/null 2>&1; then
	export TERMINAL="ghostty"
fi
export MANWIDTH=120
