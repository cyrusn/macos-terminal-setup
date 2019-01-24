BASEDIR=$(dirname $0)

echo 'updating apps / packages list files'
brew leaves > ${BASEDIR}/brew_apps.txt
brew cask list -1 > ${BASEDIR}/cask_apps.txt
npm ls -g -depth=0 --json | jq '.dependencies | keys | .[]' | cut -d '"' -f 2 > ${BASEDIR}/npm_global_packages.txt
echo 'updated'

brew update
brew upgrade
brew cask upgrade
brew cleanup

npm update -g npm
npm update -g
