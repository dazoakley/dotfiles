# Fig pre block. Keep at the top of this file.
export PATH="${PATH}:${HOME}/.local/bin"
eval "$(fig init zsh pre)"

#! /opt/homebrew/bin/zsh

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi



setopt rm_star_silent

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTCONTROL=erasedups
HISTSIZE=10000
SAVEHIST=10000
bindkey -e
# End of lines configured by zsh-newuser-install

##
## Antigen - package manager (https://github.com/zsh-users/antigen)
##

case $(uname -s) in
Darwin)
  source "/opt/homebrew/share/antigen/antigen.zsh"
  ;;
Linux)
  source "${HOME}/.antigen/antigen.zsh"
  ;;
esac

# Load the oh-my-zsh's library
antigen use oh-my-zsh

antigen bundle colored-man-pages
antigen bundle command-not-found
antigen bundle common-aliases
antigen bundle git
antigen bundle johanhaleby/kubetail
# antigen bundle kube-ps1
antigen bundle kubectl
# antigen bundle pip
antigen bundle zsh-users/zsh-completions
antigen bundle autojump
antigen theme romkatv/powerlevel10k

antigen apply

source ~/.aliases

##
## Editor settings
##

export EDITOR=$(which nvim)
export SVN_EDITOR=$EDITOR
export GIT_EDITOR=$EDITOR

##
## Build Environment
##

case $(uname -s) in
Darwin)
  # /opt/homebrew set-up
  export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:/opt/homebrew/share/npm/bin:$PATH"
  export NODE_PATH="/opt/homebrew/lib/node_modules"
  export PKG_CONFIG_PATH="/opt/homebrew/lib/pkgconfig:$PKG_CONFIG_PATH"

  # Extra path for misc scripts
  export PATH="$PATH:$HOME/Google Drive/bin"

  # Homebrew
  export LDFLAGS="-L/opt/homebrew/opt/zlib/lib -L/opt/homebrew/opt/sqlite/lib"
  export CPPFLAGS="-I/opt/homebrew/opt/zlib/include -I/opt/homebrew/opt/sqlite/include"
  export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:/opt/homebrew/opt/zlib/lib/pkgconfig:/opt/homebrew/opt/sqlite/lib/pkgconfig"

  # llvm 11 for crystal lang...
  export PATH="/usr/local/opt/llvm@11/bin:$PATH"
  ;;
Linux) ;;
esac

export PATH="$PATH:$HOME/bin:$HOME/src/github.com/dazoakley/dotfiles/bin"
export XDG_CONFIG_HOME=$HOME/.config

# ASDF
export ASDF_DIR=$HOME/.asdf
if [ -d "$ASDF_DIR" ]; then
  . $HOME/.asdf/asdf.sh
  fpath=($ASDF_DIR/completions $fpath)
fi

autoload -Uz bashcompinit
bashcompinit

# The following lines were added by compinstall
zstyle :compinstall filename '/Users/dazoakley/.zshrc'

fpath+=~/.zfunc

autoload -Uz compinit
compinit
# End of lines added by compinstall

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

# Github CLI (hub)
eval "$(hub alias -s)"

# gpg
GPG_TTY="$(tty)"
export GPG_TTY

# kube
export KUBECONFIG="${KUBECONFIG:-$HOME/.kube/config}"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# golang
export GOPATH="$HOME/go"
export PATH="$PATH:$(go env GOPATH)/bin"
export GO111MODULE="on"

# autojump
[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh

##
## Other stuff
##

eval "$(kubectl completion zsh)"
eval "$(direnv hook zsh)"
eval $(thefuck --alias)

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

##
## my prompt theme...
##

# HOSTNAME=$(hostname)

# KUBE_PS1_SYMBOL_PADDING=false
# KUBE_PS1_SEPARATOR=''
# KUBE_PS1_PREFIX='['
# KUBE_PS1_SUFFIX=']'

# PROMPT=$'%{$fg_bold[green]%}$HOSTNAME%{$reset_color%} %{$fg[yellow]%}%~%{$reset_color%}$(git_prompt_info) $(kube_ps1)\
# %{$fg_bold[green]%}%D{%H:%M} %{$fg[blue]%}❯%{$reset_color%} '

# ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%} ["
# ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%}"
# ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}*%{$fg[green]%}"
# ZSH_THEME_GIT_PROMPT_CLEAN=""

##
## LOCAL ENV OVERRIDE (non-git hosted stuff)
##
if [ -f ~/.env_setup.local ]; then
  . ~/.env_setup.local
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Fig post block. Keep at the bottom of this file.
eval "$(fig init zsh post)"

