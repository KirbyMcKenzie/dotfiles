#!/bin/bash

parse_git_branch() {
    git branch 2>/dev/null | sed -n -e 's/^\* \(.*\)/(\1)/p'
}

alias git-s='git status'

COLOR_DEF='\[\e[0m\]'
COLOR_USR='\[\e[38;5;243m\]'
COLOR_DIR='\[\e[38;5;197m\]'
COLOR_GIT='\[\e[38;5;39m\]'

if [ -n "$CODESPACES" ]; then
  PROMPT_USER="@kirby's codespace"
else
  PROMPT_USER="\u"
fi

export PS1="${COLOR_USR}${PROMPT_USER} ${COLOR_DIR}\w ${COLOR_GIT}\$(parse_git_branch)${COLOR_DEF} \$ "

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # loads nvm bash_completion

if [ -f .ruby-version ]; then
    rvm use
fi

if [ -z "$GITHUB_SPRINGCARE_TOKEN" ] && [ -n "$GITHUB_TOKEN" ]; then
  export GITHUB_SPRINGCARE_TOKEN="$GITHUB_TOKEN"
fi
