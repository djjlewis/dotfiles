# ── History / completion ──────────────────────────────────────────────────────
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
bindkey -v
zstyle :compinstall filename '$HOME/.zshrc'

# Rebuild the completion dump once a day. -C reuses the dump without the
# per-function check, which is most of the shell's startup time.
autoload -Uz compinit
if [ ! -e ~/.zcompdump ] || [ -n "$(command find ~/.zcompdump -mmin +1440 2>/dev/null)" ]; then
    compinit
else
    compinit -C
fi

# ── Environment ───────────────────────────────────────────────────────────────
export CLICOLOR=1
export FZF_DEFAULT_COMMAND='rg --files'

# ── OS-specific aliases ──────────────────────────────────────────────────────
case "$OSTYPE" in
    darwin*)
        # Homebrew GNU coreutils prefixed with 'g'
        alias ls='gls -F --color=auto --group-directories-first'
        alias grep='ggrep --color=auto'
        alias fgrep='gfgrep --color=auto'
        alias find='gfind'
        alias awk='gawk'
        alias sed='gsed'
        alias cat='bat -pp'
        alias ll='ls -Fhl --color=auto --group-directories-first'
        if [ -x /opt/homebrew/bin/brew ]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        fi
        ;;
    linux-gnu*)
        alias ls='ls -F --color=auto --group-directories-first'
        alias grep='grep --color=auto'
        alias ip='ip -color=auto'
        # On GNU ls, -G means "no group" — DON'T use it
        alias ll='ls -Fhl --color=auto --group-directories-first'
        ;;
esac

# ── Cross-platform aliases ───────────────────────────────────────────────────
if command -v eza >/dev/null 2>&1; then
    alias ls='eza -lh --group-directories-first --icons=auto'
    alias ll='ls'
    alias lsa='ls -a'
    alias lt='eza --tree --level=2 --long --icons=auto --git'
    alias lta='lt -a'
fi

alias plz='sudo'
alias la='ll -a'
alias vim=nvim
alias python=python3
alias pip=pip3
alias pw='cd ~/projects/work'
alias t='tmux new-session -A -s Work'

# Omarchy's aliases. https://omarchy.org/manual/shell-tools/
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias g='git'
alias gcm='git commit -m'
alias gcam='git commit -a -m'
alias gcad='git commit -a --amend'
alias d='docker'
# Omarchy opens the file manager on the shell's directory with
# Super+Shift+Alt+F. macOS has no window-manager equivalent bound, so this is
# the shell command for it.
alias o='open .'

n() {
    if [ "$#" -eq 0 ]; then
        command nvim .
    else
        command nvim "$@"
    fi
}

# Linux has no `open`. Omarchy defines one so the same command works on both.
if [[ "$OSTYPE" == linux-gnu* ]] && ! command -v open >/dev/null 2>&1; then
    open() { xdg-open "$@" >/dev/null 2>&1 & }
fi

# Omarchy's fast file picker and fuzzy history search. The fzf integration owns
# Ctrl+R; Ctrl+T and Alt+C also become available when fzf is installed.
if command -v fzf >/dev/null 2>&1; then
    source <(fzf --zsh)
    if command -v bat >/dev/null 2>&1; then
        ff() { fzf --preview 'bat --style=numbers --color=always -- {}'; }
    else
        ff() { fzf; }
    fi

    # Open the selection straight in the editor.
    eff() {
        local file
        file="$(ff)" && [ -n "$file" ] && "${EDITOR:-nvim}" "$file"
    }
fi

# Keep normal cd semantics; use z/zi for learned directory jumps.
if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init zsh)"
fi

# ── Shell functions ──────────────────────────────────────────────────────────
# Omarchy keeps these in default/bash/fns. Each file says where it differs.
# https://omarchy.org/manual/shell-functions/
for _fn in "$HOME/.config/zsh/fns"/*(N); do
    source "$_fn"
done
unset _fn

# ── Prompt ───────────────────────────────────────────────────────────────────
if command -v starship >/dev/null 2>&1; then
    eval "$(starship init zsh)"
fi

# ── NVM (macOS via Homebrew, fallback to ~/.nvm) ─────────────────────────────
case "$OSTYPE" in
    darwin*)
        export NVM_DIR="$HOME/.nvm"
        if [ -s "/opt/homebrew/opt/nvm/nvm.sh" ]; then
            \. "/opt/homebrew/opt/nvm/nvm.sh"
            [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
        elif [ -s "$NVM_DIR/nvm.sh" ]; then
            \. "$NVM_DIR/nvm.sh"
            [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
        fi
        ;;
esac

# ── OrbStack (macOS-only container/VM tool) ──────────────────────────────────
if [[ "$OSTYPE" == darwin* ]] && [ -f ~/.orbstack/shell/init.zsh ]; then
    source ~/.orbstack/shell/init.zsh
fi

# ── zsh plugins (Arch installs them as system files; load if present) ────────
if [[ "$OSTYPE" == linux-gnu* ]]; then
    [ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ] \
        && source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
    [ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] \
        && source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
