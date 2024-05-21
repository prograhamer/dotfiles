if status is-interactive
  fish_vi_key_bindings

  set -g fish_autosuggestion_enabled 0

  set -U hydro_multiline true

  fish_add_path -m ~/.local/bin
  fish_add_path -m ~/go/bin
  if [ $(uname -o) = "Darwin" ]
    fish_add_path /opt/homebrew/bin
  end

  alias rm='rm -I'
  alias view='nvim -MR'
  alias vim='nvim'

  set -Ux EDITOR nvim
end

function fish_greeting
  if command -q cowthink && command -q fortune
    fortune | cowthink
  end
end

function fish_right_prompt
  set -f date (date '+%H:%M:%S')

  if command -q kubectl
    set -f kube_context (kubectl config current-context 2>/dev/null || echo '[no context]')
    string join '' -- (set_color purple) '⎈ ' $kube_context (set_color normal) ' ' (set_color green) $date (set_color normal)
  else
    string join '' -- (set_color green) $date (set_color normal)
  end
end
