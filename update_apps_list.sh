#!/bin/bash

BASEDIR=$(dirname $0)

echo 'Upgrading brew and brew cask apps...'
brew update
brew upgrade
brew upgrade --cask
brew cleanup

echo 'Upgrading npm ...'
npm install npm@latest -g

echo 'Updating npm global packages ...'
npm update -g

echo 'Updating pip3 packages ...'
pip3 list --outdated --format=freeze | grep -v '^\-e' | cut -d '=' -f 1 | xargs -n1 pip3 install -U

echo 'All apps are updated'

echo 'Updating installed apps / packages list'
brew leaves > ${BASEDIR}/apps/brew.txt
brew cask list -1 > ${BASEDIR}/apps/cask.txt
npm ls -g -depth=0 --json | jq '.dependencies | keys | .[]' | cut -d '"' -f 2 > ${BASEDIR}/apps/npm_global_packages.txt
pip3 list --not-required --format=freeze > ${BASEDIR}/apps/pip.txt
fisher self-update

echo 'Lists are updated'
