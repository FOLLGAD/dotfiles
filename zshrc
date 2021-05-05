# {{{ General config

export LANG=en_US.UTF-8
export EDITOR="nvim"
export PATH="$PATH:$HOME/.local/bin"

alias hg="history | sort -r | fzf" # use ctrl-R instead
alias vim=nvim
alias .="source"
alias ..="cd .."
alias ...="cd ../.."

HIST_STAMPS="yyyy-mm-dd"

function f {
    return "$(fd . $1 | fzy)"
}

# }}}

# {{{ Oh my zsh

plugins=(git vi-mode zsh-syntax-highlighting)

export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

# }}}

source $HOME/.zshrc_local

# case insensitive shit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
export CASE_SENSITIVE="true"
setopt nocaseglob

# {{{ Prompt line

oldPS1="$PS1"

e[1]="🌳"
e[2]="🌿"
e[3]="🪴"
e[4]="🌵"
e[5]="🌱"
e[6]="🌷"
e[7]="🌻"

random_plant() {
    size=${#e[@]}
    index=$(($RANDOM % $size))
    EMOJI=${e[$index+1]}
}

random_plant

autoload -Uz vcs_info
precmd () { vcs_info }

zstyle ':vcs_info:*' formats '(%b) '

export PS1='%n@%m %2~ $vcs_info_msg_0_${EMOJI-❌} '

# Vim mode prompt
function zle-line-init zle-keymap-select {
    VIM_NORMAL_PROMPT="%{$fg_bold[yellow]%} [% VI]%  %{$reset_color%}"
    # VIM_INSERT_PROMPT="%{$fg_bold[green]%} [% INS]%  %{$reset_color%}"
    VIM_INSERT_PROMPT=""
    RPS1="${${KEYMAP/vicmd/$VIM_NORMAL_PROMPT}/(main|viins)/$VIM_INSERT_PROMPT}"
    RPS2=$RPS1
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

# }}}

# Programs

eval "$(direnv hook zsh)"
