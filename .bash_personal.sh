export PATH="/Users/$(whoami)/bin:/usr/local/opt/coreutils/libexec/gnubin:$PATH"

CYAN="\[$(tput setaf 6)\]"
GREEN="\[$(tput setaf 2)\]"
RED="\[$(tput setaf 1)\]"
CRESET="\[$(tput sgr0)\]"

function exit_status() {
  status=$?
  if [[ $status -ne 0 ]]; then
    echo "$RED\\\$?=$status$CRESET "
  fi
}

function git_status() {
  if git rev-parse HEAD &>/dev/null; then
    GITC="$GREEN"
    STAR=""

    if ! git diff-files --quiet; then
      GITC="$RED"
    elif ! git diff-index --quiet --cached HEAD; then
      STAR="*"
    fi

    branch=$(git rev-parse --abbrev-ref HEAD)
    if [[ ${#branch} -ge 30 ]]; then
      branch="${branch:0:27}..."
    fi

    echo ":$GITC$branch$STAR$CRESET"
  fi
}

function path() {
  path=${PWD/#$HOME/'~'}
  if [[ ${#path} -ge 30 ]];then
    path=${path: -27}
    path=".../${path#*\/}"
  fi

  echo $path
}

function set_prompt() {
  export PS1="$(exit_status)$(date +%H%M) $CYAN$(path)$CRESET$(git_status)> "
}

export PROMPT_COMMAND="set_prompt"

export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

export EDITOR='vim'

export PYTHONDONTWRITEBYTECODE=1

alias ll='ls -l'
alias la='ls -Al'
alias view='vim -MR'
alias js='python -m json.tool'
alias grep='grep --color=auto --exclude ".*.swp" --exclude ".*.swo" --exclude "ruby.tags" --exclude "python.tags"'
alias be='bundle exec'
alias espresso='caffeinate -disu -w 1'
alias melatonin='/System/Library/CoreServices/"Menu Extras"/User.menu/Contents/Resources/CGSession -suspend'
alias restore_order='killall Dock'
gr() { grep -r "$1" .; }
gir() { grep -ir "$1" .; }
grl() { grep -rl "$1" .; }
girl() { grep -irl "$1" .; }

function aws_cpr() {
  if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: $0 <Source path> <Include pattern>"
    return
  fi

  aws s3 cp "$1" . --recursive --exclude '*' --include "$2"
}

function update_ruby_tags() {
  paths=$(
    for f in $(find . -name Gemfile); do
      (cd "$(dirname "$f")" && (bundle check || bundle install) >/dev/null 2>&1 && bundle list --paths);
    done | sort -u
  )
  ctags -R --languages=ruby --exclude=.git --exclude=log --exclude=vendor -f ruby.tags . $paths
}
