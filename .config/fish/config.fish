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
  string join '' -- (set_color green) (date "+%H:%M:%S") (set_color normal)
end
