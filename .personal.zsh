export GOPATH="${HOME}/go"
export PATH="${PATH}:${HOME}/.local/bin:${GOPATH}/bin"

if [[ "$(uname -s)" = "Darwin" ]]; then
  export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
fi

export EDITOR='nvim'

# Gotta have them vi keys
bindkey -v

# Aliases
alias vim='nvim'
alias view='nvim -MR'
alias k='kubectl'
alias gcd='cd $(git rev-parse --show-toplevel)'
