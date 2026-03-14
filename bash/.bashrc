set -o vi
set -o noclobber

#export FZF_DEFAULT_COMMAND='git ls-files'
#export FZF_DEFAULT_COMMAND='rg --files --hidden'
export FZF_DEFAULT_COMMAND='rg --files'

alias plz='sudo'
alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias ip='ip -color=auto'
alias ls='ls -F --color=auto --group-directories-first'
#alias ll='ls -FGhl --color=auto --group-directories-first'
alias ll='ls -Ghl'
alias la='ll -a'
alias vim=nvim

# Set LESS env vars for coloured output in man pages
man() {
    LESS=-r				\
    LESS=-r				\
    LESS_TERMCAP_mb=$'\e[01;30m' 	\
    LESS_TERMCAP_md=$'\e[01;36m'	\
    LESS_TERMCAP_me=$'\e[0m'		\
    LESS_TERMCAP_se=$'\e[0m' 		\
    LESS_TERMCAP_so=$'\e[01;47;30m' 	\
    LESS_TERMCAP_ue=$'\e[0m'		\
    LESS_TERMCAP_us=$'\e[04;35m'	\
    command man "$@"
}

# Run twolfson/sexy-bash-prompt
# TODO: find something less bloated
. ~/.bash_prompt

export NVM_DIR="$HOME/.nvm"
if [ -s "/opt/homebrew/opt/nvm/nvm.sh" ]; then
    \. "/opt/homebrew/opt/nvm/nvm.sh"
    [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
elif [ -s "$NVM_DIR/nvm.sh" ]; then
    \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
fi
