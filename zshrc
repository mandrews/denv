export EDITOR='vim'
export VISUAL='vim'
export GIT_EDITOR='vim'
export PAGER='more'

alias vi=vim

# Clipper
alias pbcopy="nc host.docker.internal 8377"

# oh-my-zsh
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="blinks"
plugins=(vi-mode zsh-syntax-highlighting history-substring-search git)
source $ZSH/oh-my-zsh.sh

# oh-my-zsh overrides
unsetopt sharehistory
unset RPROMPT

# vi mode
bindkey -v

# vi editor mode
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line

bindkey -M viins '^h'  backward-delete-char

# vi incremental search
bindkey '^R' history-incremental-search-backward
bindkey '^S' history-incremental-search-forward
bindkey '^P' history-search-backward
bindkey '^N' history-search-forward

# fixes issues with CTRL-C binding
stty sane
