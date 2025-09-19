#!/bin/zsh

setopt PROMPT_SUBST
autoload -Uz compinit; compinit

parse_git_branch() {
  local b
  b=$(git rev-parse --abbrev-ref HEAD 2>/dev/null) || return
  if [ "$b" = "HEAD" ]; then
    b=$(git describe --tags --always 2>/dev/null)
  fi
  [ -n "$b" ] && printf '(%s)' "$b"
}

COLOR_USR='%F{243}'   # gray
COLOR_DIR='%F{197}'   # pink/red
COLOR_GIT='%F{39}'    # blue/cyan
COLOR_DEF='%f'        # reset

if [ -n "$CODESPACES" ]; then
  PROMPT_USER="@kirby's codespace"
else
  PROMPT_USER="%n"   # username
fi

# Prompt: user  dir  (git-branch)  prompt-char
export PS1="${COLOR_USR}${PROMPT_USER} ${COLOR_DIR}%~ ${COLOR_GIT}\$(parse_git_branch)${COLOR_DEF} %# "


# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# Ruby (rvm)
if [ -f .ruby-version ]; then
  rvm use
fi

if [ -z "$GITHUB_SPRINGCARE_TOKEN" ] && [ -n "$GITHUB_TOKEN" ]; then
  export GITHUB_SPRINGCARE_TOKEN="$GITHUB_TOKEN"
fi
