#!/bin/bash

set -uf

DIRNAME=$(pwd)

for f in $(ls -A | grep  '^\.' | grep -Ev '^\.(config|git)$'); do
  ln -vhs "$DIRNAME/$f" "$HOME/$f"
done

for f in $(ls -A .config); do
  ln -vhs "${DIRNAME}/.config/${f}" "$HOME/.config/${f}"
done

if [ ! -s ~/.gitconfig-user ]; then
  echo "Create a file ~/.gitconfig-user to configure your user name/email for commits"
fi
