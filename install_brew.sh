#!/bin/bash

## check brew
brew update

## brew install fonts
brew tap homebrew/cask
brew tap homebrew/cask-drivers
brew tap homebrew/cask-fonts

echo "Installing brew apps..."
while read -r line; do
    brew install "$line"
done < "apps/brew.txt"

echo "Installing brew cask apps..."
while read -r line; do
    # brew cask install "$line"
    brew install --cask "$line"
done < "apps/cask.txt"

## brew cleanup
brew cleanup

## reload QuickLook
qlmanage -r
