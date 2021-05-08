# {{{ General config

export LANG=en_US.UTF-8
export EDITOR="nvim"
export PATH="$PATH:$HOME/.local/bin"

setopt menu_complete # https://unix.stackexchange.com/questions/12288/zsh-insert-completion-on-first-tab-even-if-ambiguous

# alias hg="history | sort -r | fzf" # use ctrl-R instead
alias hg="kitty +kitten hyperlinked_grep"
alias vim=nvim
alias .="source"
alias ..="cd .."
alias ...="cd ../.."
alias gpr="git pull --rebase"
alias gs="git status"
alias today="date '+%m-%d-%Y'"
alias now="date '+%H:%M:%S'"

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

R=$reset_color
G=$fg_bold[green]
PROMPT_NAME='%n@%B%F{green}%m%f%b '
PROMPT_PATH='%U%F{red}%2~%f%u '

zstyle ':vcs_info:*' check-for-changes true
# zstyle ':vcs_info:*' formats '( %b%u%c) '
zstyle ':vcs_info:*' formats '(%b%u%c) '
zstyle ':vcs_info:*' unstagedstr '*'
zstyle ':vcs_info:*' stagedstr '+'
PROMPT_VCS='$vcs_info_msg_0_'

export PS1=$PROMPT_NAME$PROMPT_PATH$PROMPT_VCS'${EMOJI-❌} '
# export RPS1='$(now)'

# Vim mode prompt
function zle-line-init zle-keymap-select {
    VIM_NORMAL_PROMPT="%B%F{yellow} [% VI]% %b%f"
    # VIM_INSERT_PROMPT="%{$fg_bold[green]%} [% INS]%  %{$reset_color%}"
    VIM_INSERT_PROMPT=""

    RPS1="${${KEYMAP/vicmd/$VIM_NORMAL_PROMPT}/(main|viins)/$VIM_INSERT_PROMPT} $(now)"
    RPS2=$RPS1
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

# }}}

# Programs

eval "$(direnv hook zsh)"
