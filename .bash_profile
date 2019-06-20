#! /bin/bash

# shellcheck source=/dev/null
. "$HOME/.aliases"
# shellcheck source=/dev/null
. "$HOME/.env_setup"

##
## Bash completion
##

export BASH_COMPLETION_COMPAT_DIR="/usr/local/etc/bash_completion.d"
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

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
## Integrate kube-ps1 and git into prompt
##

KUBE_PS1_SH="$(brew --prefix)/opt/kube-ps1/share/kube-ps1.sh"
GIT_PROMPT_DIR=$(brew --prefix)/opt/bash-git-prompt/share

if [ -f "$KUBE_PS1_SH"  ] && [ -f "$GIT_PROMPT_DIR/gitprompt.sh" ]; then
  # shellcheck source=/dev/null
  . "$KUBE_PS1_SH"

  # shellcheck source=/dev/null
  . "$GIT_PROMPT_DIR/prompt-colors.sh"

  GIT_PROMPT_START='$(kube_ps1)\n'
  GIT_PROMPT_START="${GIT_PROMPT_START}_LAST_COMMAND_INDICATOR_ ${Yellow}\w${ResetColor}"
  GIT_PROMPT_THEME=Solarized

  # shellcheck source=/dev/null
  . "$GIT_PROMPT_DIR/gitprompt.sh"
fi

# Homebrew bash completion
if [ -f "$(brew --prefix)/etc/bash_completion" ]; then
  # shellcheck source=/dev/null
  source "$(brew --prefix)/etc/bash_completion"
fi

# gcloud
gcloud_loc="$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk"
if [ -f "${gcloud_loc}/path.bash.inc" ]; then
  # shellcheck source=/dev/null
  source "${gcloud_loc}/path.bash.inc"
  # shellcheck source=/dev/null
  source "${gcloud_loc}/completion.bash.inc"
fi

# kube
eval "$(kubectl completion bash)"
eval "$(minikube completion bash)"

# python poetry
eval "$(poetry completions bash)"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
