#!/bin/bash

# use `brew leaves` to list only installed top level formulas

## cli apps
binaries=(
  coreutils
  go
  highlight
  node
  todo-txt
  vim
  youtube-dl
  zsh
)

# cask apps
apps=(
  1password
  alfred
  appcleaner
  bartender
  dropbox
  fantastical
  font-inconsolata
  font-ubuntu-mono-derivative-powerline
  google-chrome
  iterm2
  microsoft-office
  qlcolorcode
  qlmarkdown
  qlstephen
  qlvideo
  quicklook-csv
  quicklook-json
  quicklookase
  spotify
  suspicious-package
  teamviewer
  the-unarchiver
  transmit
  visual-studio-code
  webpquicklook
  whatsapp
)

## check brew
brew update

## brew install fonts
brew tap caskroom/fonts

echo "installing brew apps..."
brew install ${binaries[@]}

echo "installing brew cask apps..."
brew cask install ${apps[@]}

## brew cleanup
brew cleanup

## reload QuickLook
qlmanage -r
