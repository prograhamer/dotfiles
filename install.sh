set -eu

DIRNAME=$(pwd)

git submodule update --init

(cd .vim/fzf && yes n | ./install)

for f in $(ls -A | grep  '^\.' | grep -v '^\.git$'); do
  ln -nsf "$DIRNAME/$f" "$HOME/$f"
done

if [ ! -s ~/.gitconfig-user ]; then
  echo "Create a file ~/.gitconfig-user to configure your user name/email for commits"
fi
