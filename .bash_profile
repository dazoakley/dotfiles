##
## Modify the bash history functions
##

# remove duplicate entries
export HISTCONTROL=erasedups
# increase size of hist to 10,000 entries
export HISTSIZE=10000
# append new entries to end of file - good for multiple sessions
shopt -s histappend

##
## Write to history after each command
##

export PROMPT_COMMAND='history -a'

##
## Integrate SCM's into prompt...
##

if [ -f "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh" ]; then
  __GIT_PROMPT_DIR=$(brew --prefix)/opt/bash-git-prompt/share
  source "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh"
fi

##
## Terminal colours (after installing GNU coreutils)
##

export TERM=xterm-256color
if [ "$TERM" != "dumb" ]; then
  lscols=auto
  export LS_OPTIONS='--color=auto'

  case $(uname -s) in
    Darwin)
      eval "`gdircolors -b $HOME/.dir_colors`"
    ;;
    Linux)
      eval "`dircolors -b $HOME/.dir_colors`"
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

##
## Enable bash completion
##

case $(uname -s) in
  Darwin)
    if [ -f `brew --prefix`/etc/bash_completion ]; then
      . `brew --prefix`/etc/bash_completion
    fi
  ;;
esac

##
## Other config files...
##

source "$HOME/.aliases"
source "$HOME/.env_exports"

if [ -e "$HOME/.bash_profile.local" ]; then
  source "$HOME/.bash_profile.local"
fi

# Homebrew bash completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

# Github CLI (hub)
eval "$(hub alias -s)"

## VIM

#if [ $VIM ]; then
#  export PS1='[VIM]\h:\w\$ '
#  unset LS_OPTIONS
#fi

# ASDF
if [[ -d "$HOME/.asdf" ]]; then
  . $HOME/.asdf/completions/asdf.bash
fi

# gcloud
source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc'
source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc'

