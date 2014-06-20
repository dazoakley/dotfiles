# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="norm"

# Set to this to use case-sensitive completion
CASE_SENSITIVE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)

source $ZSH/oh-my-zsh.sh

##
## My setup...
##

source $HOME/.aliases
source $HOME/.env_exports

##
## Terminal colours (after installing GNU coreutils)
##

export TERM=xterm-256color
if [ "$TERM" != "dumb" ]; then
  lscols=auto
  export LS_OPTIONS='--color=auto'

  case $(uname -s) in
    Darwin)
      eval "`gdircolors $HOME/.dir_colors`"
    ;;
    Linux)
      eval "`dircolors $HOME/.dir_colors`"
    ;;
  esac
fi

case $(uname -s) in
  Darwin)
    alias ls='gls $LS_OPTIONS -hF'
    alias ll='gls $LS_OPTIONS -lhF'
    alias l='gls $LS_OPTIONS -lAhF'
  ;;
  Linux)
    alias ls='ls $LS_OPTIONS -hF'
    alias ll='ls $LS_OPTIONS -lhF'
    alias l='ls $LS_OPTIONS -lAhF'
  ;;
esac

# Make the arrow keys work as expected in stuff... (i.e. irb)
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward
bindkey "^[[1;9D" backward-word
bindkey "^[[1;9C" forward-word

# git
git(){ hub "$@" }

# zsh-completions
fpath=(/usr/local/share/zsh-completions $fpath)
fpath=(/usr/local/share/zsh/site-functions $fpath)

# RBENV
if [[ -d "$HOME/.rbenv" ]]; then
  eval "$(rbenv init -)"
fi

# Report CPU usage for commands running longer than 10 seconds
REPORTTIME=10

# Stop trying to flipping autocorrect rspec!!!
alias rspec='noglob rspec'
alias rake="noglob rake"

