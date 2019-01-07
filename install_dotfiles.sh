#!/bin/bash

main () {
  ## create symlink for all dotfiles
  location=".macos-terminal-setup"
  target=$HOME/$location/dotfiles

  for file in $(\ls $target); do
    if [ $file != README.md ]; then
      if [ ! -L $HOME/.${file} ]; then
        echo "creating symlink for ."$file "..."
        ln -s ${target}/${file} $HOME/.${file}
      fi
    fi
  done
}

main
