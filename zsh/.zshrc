# ── History / completion ──────────────────────────────────────────────────────
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
bindkey -v
zstyle :compinstall filename '$HOME/.zshrc'

autoload -Uz compinit
compinit

bindkey '^R' history-incremental-pattern-search-backward

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
        # ls -G is colour on BSD ls (still relevant if gls isn't installed)
        alias ll='ls -FGhl --color=auto --group-directories-first'
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
alias plz='sudo'
alias la='ll -a'
alias vim=nvim
alias python=python3
alias pip=pip3
alias pw='cd ~/projects/work'

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
