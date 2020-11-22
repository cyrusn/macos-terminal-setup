if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

function l
  ls -a $argv
end

function trash
  mv $argv ~/.Trash
end

function youtube-dl
  command youtube-dl -o "~/Desktop/%(title)s.%(ext)s" $argv
end

function audio-dl
  youtube-dl --extract-audio --audio-quality=0 --audio-format=m4a $argv
end

function python
  command python3 $argv
end

function pip
  command pip3 $argv
end

function t
  command task $argv
end

set EDITOR 'code -w'

# disable fish shell greeting
set fish_greeting

# set Env
set -xg LC_ALL en_US.UTF-8  
set -xg LANG en_US.UTF-8

# set node path
set -xg NODE_PATH $HOME/.npm-global
set -xg PATH $NODE_PATH/bin $PATH
set -xg NODE_PATH $HOME/.npm-global/lib/node_modules $NODE_PATH

# set golang path
set -xg GOROOT "/usr/local/opt/go/libexec"
set -xg GOPATH $HOME/golang
set -xg PATH $GOROOT/bin $GOPATH/bin $PATH

# set taskwarrior rc location
set -xg TASKRC $HOME/.config/task/.taskrc

# startup starfish
starship init fish | source
set -g fish_user_paths "/usr/local/opt/python@3.8/bin" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/python@3.8/bin" $fish_user_paths
