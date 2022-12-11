HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# zinit plugins
zinit ice lucid wait'0'
zinit light joshskidmore/zsh-fzf-history-search

export GOPATH="${HOME}/go"
export PATH="${HOME}/.local/bin:${PATH}:${GOPATH}/bin"

if [[ "$(uname -s)" = "Darwin" ]]; then
  export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
fi

export EDITOR='nvim'

# Gotta have them vi keys
bindkey -v
bindkey "^R" history-incremental-search-backward

# Aliases
alias cdz='cd $(fd -td | fzf)'
alias gcd='cd $(git rev-parse --show-toplevel)'
alias k='kubectl'
alias ls='ls --color=auto'
alias rm='rm -I'
alias view='nvim -MR'
alias vim='nvim'
