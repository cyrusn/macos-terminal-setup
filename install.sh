main() {
	# setting for terminal
	location=".macos-terminal-setup"

	# install brew
	if [ ! $(which brew) ]; then
		echo "Installing homebrew..."
		ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	fi
	
	## install zsh
	if [ ! $(which zsh) ]; then
		brew install zsh
	fi

	## install coreutils for .dir_colors
	if [ ! $(brew list | grep coreutils) ]; then
		brew install coreutils
	fi

	# install oh-my-zsh
	if [ ! -d $HOME/.oh-my-zsh ]; then
		echo "installing zsh..."
		sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
	fi

	## create symlink for zsh-custom for customization
	if [ ! -L $HOME/.zsh-custom ]; then
		echo "creating symlink for .zsh-custom ..."
		ln -s $HOME/$location/zsh-custom $HOME/.zsh-custom
	fi

	## create custom dir for npm global packages
	mkdir ~/.npm-global
	npm config set prefix '.npm-global'

	## create symlink for all dotfiles
	bash $HOME/$location/install_dotfiles.sh

	## install all brew and brew cask app
	bash $HOME/$location/install_brew.sh

	## install all npm global package
	bash $HOME/$location/install_npm.sh
}

main
