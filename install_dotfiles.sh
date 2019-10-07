#!/bin/bash

main () {
    ## create symlink for all dotfiles
    location=".macos-terminal-setup"
    target=$HOME/$location/dotfiles
    
    for file in $(\ls -A $target); do
        if [ ! -L $HOME/${file} ]; then
            echo "Creating symlink for ."$file "..."
            ln -s ${target}/${file} $HOME/${file}
        fi
    done
}

main
