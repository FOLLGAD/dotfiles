# For searching my docs :)
docs() {
    if [ -n "$1" ]; then
        rg -S -C 3 $1 ~/docs;
    fi
}

export BAT_THEME="Gruvbox (light)"

if [ -f ~/.zshrc_local ]; then
	source ~/.zshrc_local
fi

# Use the silver surfer (ag) for fzf
# Ignores .gitignore:d files and other stuff
if [ -x "$(command -v ag)" ]; then
	export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
fi

source ~/.antigen.zsh

eval "$(starship init zsh)"

export ZSH="/home/emil/.oh-my-zsh"

source $ZSH/oh-my-zsh.sh

source $HOME/.antigen.zsh
antigen use oh-my-zsh

antigen apply

alias .="source"
alias ..="cd .."
alias ...="cd ../.."
alias :q="exit" # vim moment
alias open="xdg-open"
alias vim=nvim

export EDITOR='vim'

# Enforce brightness by changing the brightness of all connected monitors
alias brite="xrandr | grep ' connected' | cut -f 1 -d ' ' | xargs -I % xrandr --output % --brightness"

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
# HISTFILE=~/.cache/zsh/history

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="yyyy-mm-dd"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# # Edit command in vim with ctrl-e
# autoload edit-command-line; zle -N edit-command-line
# bindkey '^e' edit-command-line

# Enable vim mode
#bindkey -v

