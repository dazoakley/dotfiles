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
## Integrate SCM's into prompt...
##

parse_git_branch () {
	git name-rev HEAD 2> /dev/null | sed 's#HEAD\ \(.*\)# (git::\1)#'
}
parse_hg_branch() {
    hg branch 2> /dev/null | awk '{print " (hg::"$1")" }'
}
parse_svn_branch() {
	parse_svn_url | sed -e 's#^'"$(parse_svn_repository_root)"'##g' | egrep -o '(tags|branches)/[^/]+|trunk' | egrep -o '[^/]+$' | awk '{print " (svn::"$1")" }'
}
parse_svn_url() {
	svn info 2>/dev/null | sed -ne 's#^URL: ##p'
}
parse_svn_repository_root() {
	svn info 2>/dev/null | sed -ne 's#^Repository Root: ##p'
}

BLACK="\[\033[0;38m\]"
RED="\[\033[0;31m\]"
RED_BOLD="\[\033[01;31m\]"
BLUE="\[\033[01;34m\]"
GREEN="\[\033[0;32m\]"

export PS1="$BLACK[ \u@$RED\h $GREEN\w$RED_BOLD\$(parse_git_branch)\$(parse_svn_branch)\$(parse_hg_branch)$BLACK ] "

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

source /usr/local/etc/bash_completion.d/git-completion.bash

# github cli
eval "$(gh alias -s)"

## VIM

if [ $VIM ]; then
  export PS1='[VIM]\h:\w\$ '
  unset LS_OPTIONS
fi
