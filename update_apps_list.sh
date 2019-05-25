#!/bin/bash

BASEDIR=$(dirname $0)

echo 'updating installed apps / packages list'
brew leaves > ${BASEDIR}/apps/brew.txt
brew cask list -1 > ${BASEDIR}/apps/cask.txt
npm ls -g -depth=0 --json | jq '.dependencies | keys | .[]' | cut -d '"' -f 2 > ${BASEDIR}/apps/npm_global_packages.txt
echo 'updated list'

brew update
brew upgrade
brew cask upgrade
brew cleanup
echo 'upgraded brew and brew cask apps'

npm install npm@latest -g
echo 'upgraded npm'

npm update -g
echo 'updated npm global package'
