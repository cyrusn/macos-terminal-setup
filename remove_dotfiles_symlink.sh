#!/bin/bash

# setting for terminal
location=".macos-terminal-setup"

echo "Remove symlink for .zsh-custom ..."
\rm $HOME/.zsh-custom

## all dotfile setting
target=$HOME/$location/dotfiles

for file in $(\ls -A $target); do
    echo "Remove symlink for "$file "..."
    rm $HOME/${file}
done
