#!/bin/bash

## check brew
brew update

## brew install fonts
brew tap caskroom/fonts

echo "Installing brew apps..."
while read -r line; do
    brew install "$line"
done < "apps/brew.txt"

echo "Installing brew cask apps..."
while read -r line; do
    brew cask install "$line"
done < "apps/cask.txt"

## brew cleanup
brew cleanup

## reload QuickLook
qlmanage -r
