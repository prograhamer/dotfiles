CYAN="\[$(tput setaf 6)\]"
GREEN="\[$(tput setaf 2)\]"
RED="\[$(tput setaf 1)\]"
CRESET="\[$(tput sgr0)\]"

function set_prompt() {
  export PS1="$(date +%H%M) $CYAN\w$CRESET"

  if git rev-parse HEAD &>/dev/null; then
    GITC="$GREEN"
    STAR=""

    if ! git diff-files --quiet; then
      GITC="$RED"
    elif ! git diff-index --quiet --cached HEAD; then
      STAR="*"
    fi

    export PS1="$PS1:$GITC$(git rev-parse --abbrev-ref HEAD)$STAR$CRESET"
  fi

  export PS1="$PS1> "
}

export PROMPT_COMMAND="set_prompt"

export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

export EDITOR='vim'

alias ll='ls -l'
alias la='ls -Al'
alias view='vim -MR'
alias js='python -m json.tool'
alias grep='grep --color=auto --exclude ".*.swp" --exclude ".*.swo" --exclude "ruby.tags" --exclude "python.tags"'
alias ans='pushd ~/Code/ansible-playbooks'

function aws_cpr() {
  if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: $0 <Source path> <Include pattern>"
    return
  fi

  aws s3 cp "$1" . --recursive --exclude '*' --include "$2"
}
