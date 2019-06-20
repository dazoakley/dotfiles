#! /usr/local/bin/zsh

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
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

antigen bundle <<EOBUNDLES
    colored-man-pages   
    command-not-found
    common-aliases
    git
    git-prompt
    kube-ps1
    osx
    pip
    zsh-users/zsh-autosuggestions
    zsh-users/zsh-completions
    zsh-users/zsh-syntax-highlighting
EOBUNDLES

antigen theme sorin

antigen apply

source ~/.aliases
source ~/.env_setup

# kube

KUBE_PS1_SH="$(brew --prefix)/opt/kube-ps1/share/kube-ps1.sh"
if [ -f "$KUBE_PS1_SH"  ]; then
  . "$KUBE_PS1_SH"
  KUBE_PS1_SEPARATOR=':'
  KUBE_PS1_PREFIX=''
  KUBE_PS1_SUFFIX=''

  # add to sorin theme
  PROMPT='%{$fg[cyan]%}%c $(kube_ps1)$(git_prompt_info) %(!.%{$fg_bold[red]%}#.%{$fg_bold[green]%}❯)%{$reset_color%} '
fi

eval "$(kubectl completion zsh)"
eval "$(minikube completion zsh)"

# python poetry
#eval "$(poetry completions zsh)"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
