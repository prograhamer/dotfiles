#!/bin/bash

set -euf

NEOVIM_VERSION=v0.7.0

OS="$(uname -o)"
DIRNAME=$(pwd)

git submodule update --init

if [[ "${OS}" = "GNU/Linux" ]]; then
   LOCAL_DIR="${HOME}/.local"
   FONT_DIR="${LOCAL_DIR}/share/fonts"

   # Install FiraCode nerdfont
   if [[ ! -f "${FONT_DIR}/Fira Code Regular Nerd Font Complete Mono.ttf" ]]; then
     mkdir -p "${FONT_DIR}"
     pushd "${FONT_DIR}"
     wget "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip"
     unzip FiraCode.zip
     rm FiraCode.zip
     popd

     fc-cache -f
   fi

   # Install papercolor-dark terminal theme
   pushd Gogh/themes
   TERMINAL=gnome-terminal ./papercolor-dark.sh
   popd

   # Install neovim
   if [[ ! -e ~/.local/bin/nvim ]]; then
     mkdir -p "${LOCAL_DIR}/opt"
     pushd "${LOCAL_DIR}/opt"
     wget "https://github.com/neovim/neovim/releases/download/${NEOVIM_VERSION}/nvim-linux64.tar.gz"
     tar -xzf nvim-linux64.tar.gz
     rm nvim-linux64.tar.gz
     ln -s ~/.local/opt/nvim-linux64/bin/nvim ~/.local/bin/nvim
     popd
   fi
fi

for f in $(find . -maxdepth 1 -type f -name '.*'); do
  if [[ ! -e "${HOME}/${f}" ]]; then ln -vns "$DIRNAME/$f" "$HOME/$f"; fi
done

for f in $(ls -A .config); do
  if [[ ! -e "${HOME}/.config/${f}" ]]; then ln -vns "${DIRNAME}/.config/${f}" "$HOME/.config/${f}"; fi
done

# Install neovim plugins
nvim +PlugInstall +q +q

if [ ! -s ~/.gitconfig-user ]; then
  echo "Create a file ~/.gitconfig-user to configure your user name/email for commits"
fi
