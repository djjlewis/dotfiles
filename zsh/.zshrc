# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '$HOME/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

bindkey '^R' history-incremental-pattern-search-backward

export CLICOLOR=1
export FZF_DEFAULT_COMMAND='rg --files'

case "$OSTYPE" in
    darwin*)
        alias ls='gls -F --color=auto --group-directories-first'
        alias grep='ggrep --color=auto'
        alias fgrep='gfgrep --color=auto'
        alias find='gfind'
        alias awk='gawk'
        alias sed='gsed'
        alias cat='bat -pp'
        if [ -x /opt/homebrew/bin/brew ]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        fi
        ;;
    linux-gnu*)
        alias grep='grep --color=auto'
        alias ip='ip -color=auto'
        ;;
esac

alias plz='sudo'
alias ll='ls -FGhl --color=auto --group-directories-first'
alias la='ll -a'
alias vim=nvim
alias python=python3
alias pip=pip3

alias pw='cd ~/projects/work'

if command -v starship >/dev/null 2>&1; then
    eval "$(starship init zsh)"
fi

export NVM_DIR="$HOME/.nvm"
if [ -s "/opt/homebrew/opt/nvm/nvm.sh" ]; then
    \. "/opt/homebrew/opt/nvm/nvm.sh"
    [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
elif [ -s "$NVM_DIR/nvm.sh" ]; then
    \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
fi
