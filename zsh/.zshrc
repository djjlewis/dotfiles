# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
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

if [ "$OSTYPE" != linux-gnu ]; then  # Is this the macOS system?
    alias ls='gls -F --color=auto --group-directories-first'
    alias grep='ggrep --color=auto'
    alias fgrep='gfgrep --color=auto'
    alias find=gfind
    alias awk=gawk
    alias sed=gsed
else
    alias grep='grep --color=auto'
    alias ip='ip -color=auto'
fi

alias plz='sudo'
alias diff='diff --color=auto'
alias ll='ls -FGhl --color=auto --group-directories-first'
alias la='ll -a'
alias vim=nvim

eval "$(starship init zsh)"

neofetch --cpu_temp C 2> /dev/null

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
