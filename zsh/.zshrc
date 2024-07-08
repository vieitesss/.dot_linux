# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd notify
unsetopt beep extendedglob nomatch
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '$HOME/.zshrc'

autoload -Uz compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)
# END OF LINES ADDED BY COMPINSTALL

# vi mode
bindkey -v
export KEYTIMEOUT=30

# Use vim keys in tab complete menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Edit line in vim with ctrl-e
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

function include_to_path() {
    export PATH="$1:$PATH"
}

function include_to_end_path() {
    export PATH="$PATH:$1"
}

include_to_path "/sbin:/bin:/usr/bin:/usr/local/bin"
include_to_end_path "/opt"

# CONFIG
export DOTFILES="$HOME/.dot_linux"
export HOSTNAME=$(hostname)
export TERM="screen-256color"
export DISPLAY=:0.0

# Bat
export BAT_THEME="OneHalfDark"

if [[ -d /opt/jdk-11.0.13 ]]; then
    export JAVA_HOME="/opt/jdk-11.0.13"
    include_to_path "$JAVA_HOME/bin"
fi

if [[ -d /usr/local/go ]]; then
    export GO_HOME="/usr/local/go"
    include_to_path "$GO_HOME/bin"
fi

if [[ -d /snap ]]; then
    export SNAP_HOME="/snap"
    include_to_path "$SNAP_HOME/bin"
fi

if [[ -d /usr/local/textlive/2024 ]]; then
    export LTEX_HOME="/usr/local/textlive/2024"
    include_to_path "$LTEX_HOME/bin/x86_64-linux"
    export MANPATH="/usr/local/textlive/2024/texmf-dist/doc/man"
    export INFOPATH="/usr/local/textlive/2024/texmf-dist/doc/info"
fi

if [[ -d /usr/local/opt/llvm ]]; then
    include_to_path "/usr/local/opt/llvm/bin"
fi

function source_folder() {
  for file in "$1"/*; do
    if [[ -f "$file" ]]; then
      source "$file"
    fi
  done
}

source_folder "$DOTFILES/aliases"
source_folder "$HOME/obsidian/terminal"

source "$HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$HOME/.zsh/sudo.plugin.zsh"
# source "$HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
# bindkey '^j' autosuggest-accept
bindkey '^u' end-of-line
# bindkey '^ ' autosuggest-accept

if [[ -d "$HOME/.cargo" ]]; then
  source "$HOME/.cargo/env"
fi

[ -f ~/.fzf.zsh ] && source "$HOME/.fzf.zsh"

export FZF_DEFAULT_COMMAND="find ."
export FZF_CTRL_T_COMMAND="find ."
# export FZF_TMUX_OPTS="-p"
export FZF_CTRL_T_OPTS="--reverse --preview 'bat {}'"
export FZF_CTRL_R_OPTS=""
export FZF_TMUX=1
export FZF_TMUX_OPTS=''

export EDITOR="nvim"

# zsh vi mode
ZVM_VI_INSERT_ESCAPE_BINDKEY=jk
ZVM_INSERT_MODE_CURSOR='bl'

# tput cup 9999 0
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(fzf --zsh)"
