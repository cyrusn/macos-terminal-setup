#!/bin/bash

## check brew
brew update

## brew install fonts
brew tap caskroom/fonts

echo "installing brew apps..."
while read -r line; do
    brew install "$line"
done < "brew_apps.txt"

echo "installing brew cask apps..."
while read -r line; do
    brew cask install "$line"
done < "cask_apps.txt"

## brew cleanup
brew cleanup

## reload QuickLook
qlmanage -r
