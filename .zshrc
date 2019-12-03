#! /usr/local/bin/zsh

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTCONTROL=erasedups
HISTSIZE=10000
SAVEHIST=10000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/Users/dazoakley/.zshrc'

fpath+=~/.zfunc

autoload -Uz compinit
compinit
# End of lines added by compinstall

##
## Antigen - package manager (brew install antigen - https://github.com/zsh-users/antigen)
##

source /usr/local/share/antigen/antigen.zsh

# Load the oh-my-zsh's library
antigen use oh-my-zsh

antigen bundle colored-man-pages
antigen bundle command-not-found
antigen bundle common-aliases
antigen bundle git
antigen bundle kiurchv/asdf.plugin.zsh
antigen bundle kube-ps1
antigen bundle pip
antigen bundle zsh-users/zsh-completions

antigen apply

source ~/.aliases
source ~/.env_setup

##
## my prompt theme...
##

KUBE_PS1_SH="$(brew --prefix)/opt/kube-ps1/share/kube-ps1.sh"
if [ -f "$KUBE_PS1_SH"  ]; then
  . "$KUBE_PS1_SH"
  KUBE_PS1_SEPARATOR=':'
  KUBE_PS1_PREFIX='['
  KUBE_PS1_SUFFIX=']'

  PROMPT=$'%{$fg[yellow]%}%~%{$reset_color%}$(git_prompt_info) $(kube_ps1)\
%{$fg_bold[green]%}%D{%H:%M} %{$fg[blue]%}❯%{$reset_color%} '

  ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%} ["
  ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%}"
  ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}*%{$fg[green]%}"
  ZSH_THEME_GIT_PROMPT_CLEAN=""
fi

##
## Other stuff
##

eval "$(kubectl completion zsh)"

# python poetry
#eval "$(poetry completions zsh)"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
