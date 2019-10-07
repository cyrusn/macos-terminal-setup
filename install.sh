#!/bin/bash

main() {
    # setting for terminal
    location=".macos-terminal-setup"
    
    # install brew
    if [ ! $(which brew) ]; then
        echo "Installing homebrew..."
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi
    
    ## install all brew and brew cask apps
    bash $HOME/$location/install_brew.sh
    
    # install oh-my-zsh
    if [ ! -d $HOME/.oh-my-zsh ]; then
        echo "Installing oh-my-zsh..."
        sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    fi
    
    ## create symlink for all dotfiles
    bash $HOME/$location/install_dotfiles.sh
    
    ## create custom dir for npm global packages
    mkdir ~/.npm-global
    npm config set prefix '.npm-global'
    
    ## install all npm global packages
    bash $HOME/$location/install_npm.sh
    
    ## install all pip3 packages
    bash $HOME/$location/install_pip.sh
}

main
