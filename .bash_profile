##
## Editor settings
##

export EDITOR=/usr/local/bin/nvim
export SVN_EDITOR=$EDITOR
export GIT_EDITOR=$EDITOR

##
## Build Environment
##

case $(uname -s) in
  Darwin)
    export ARCHFLAGS='-arch x86_64'
  ;;
esac

# /usr/local set-up
export PATH="/usr/local/bin:/usr/local/sbin:/usr/local/share/npm/bin:$PATH"
export NODE_PATH="/usr/local/lib/node_modules"
export PKG_CONFIG_PATH="/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH"

# Extra path for misc scripts
export PATH="$PATH:$HOME/Google Drive/bin:$HOME/bin:$HOME/projects/dotfiles/bin"

# Homebrew
export HOMEBREW_GITHUB_API_TOKEN=05e96dd74d3bb400e43a800a376ee7a24171184f
export LDFLAGS="-L/usr/local/opt/zlib/lib -L/usr/local/opt/sqlite/lib"
export CPPFLAGS="-I/usr/local/opt/zlib/include -I/usr/local/opt/sqlite/include"
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:/usr/local/opt/zlib/lib/pkgconfig:/usr/local/opt/sqlite/lib/pkgconfig"
export XDG_CONFIG_HOME=$HOME/.config

if [[ -d "$HOME/.asdf" ]]; then
  # shellcheck source=/dev/null
  . "$HOME/.asdf/asdf.sh"
fi

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
## Integrate kube-ps1 into prompt
##

kube_ps1_sh="$(brew --prefix)/opt/kube-ps1/share/kube-ps1.sh"
if [ -f "$kube_ps1_sh" ]; then
  # shellcheck source=/dev/null
  . "$kube_ps1_sh"
  # PS1='[\u@\h \W $(kube_ps1)]\$ '
  PS1='$(kube_ps1)'$PS1
fi

##
## Integrate git into prompt...
##

if [ -f "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh" ]; then
  __GIT_PROMPT_DIR=$(brew --prefix)/opt/bash-git-prompt/share
  export __GIT_PROMPT_DIR
  export GIT_PROMPT_THEME=Solarized
  # shellcheck source=/dev/null
  . "$__GIT_PROMPT_DIR/gitprompt.sh"
fi

##
## Terminal colours (after installing GNU coreutils)
##

export TERM=xterm-256color
if [ "$TERM" != "dumb" ]; then
  export LS_OPTIONS='--color=auto'

  case $(uname -s) in
    Darwin)
      eval "$(gdircolors -b "$HOME/.dir_colors")"
    ;;
    Linux)
      eval "$(dircolors -b "$HOME/.dir_colors")"
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

# Homebrew bash completion
if [ -f "$(brew --prefix)/etc/bash_completion" ]; then
  # shellcheck source=/dev/null
  . "$(brew --prefix)/etc/bash_completion"
fi

# Github CLI (hub)
eval "$(hub alias -s)"

# ASDF
if [[ -d "$HOME/.asdf" ]]; then
  # shellcheck source=/dev/null
  . "$HOME/.asdf/completions/asdf.bash"
fi

# gcloud
gcloud_loc="$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk"
if [ -f "${gcloud_loc}/path.bash.inc" ]; then
  # shellcheck source=/dev/null
  . "${gcloud_loc}/path.bash.inc"
  # shellcheck source=/dev/null
  . "${gcloud_loc}/completion.bash.inc"
fi
export GOOGLE_APPLICATION_CREDENTIALS="$HOME/.config/gcloud/application_default_credentials.json"

# kube
export KUBECONFIG="${KUBECONFIG:-$HOME/.kube/config}"
eval "$(kubectl completion bash)"
eval "$(minikube completion bash)"

# gpg
GPG_TTY="$(tty)"
export GPG_TTY

##
## Other config files...
##

# shellcheck source=/dev/null
. "$HOME/.aliases"