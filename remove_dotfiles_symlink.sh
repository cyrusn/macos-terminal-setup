# setting for terminal
location="macos-terminal-setup"

echo "remove symlink for .zsh-custom ..."
\rm $HOME/.zsh-custom

## all dotfile setting
target=$HOME/$location/dotfiles

for file in $(\ls $target); do
  if [ $file != README.md ]; then
    echo "remove symlink for ."$file "..."
    rm $HOME/.${file}
  fi
done
