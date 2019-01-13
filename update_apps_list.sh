brew leaves > brew_apps.txt
brew cask list -1 > cask_apps.txt
npm ls -g -depth=0 --json | jq '.dependencies | keys | .[]' | cut -d '"' -f 2 > npm_global_packages.txt