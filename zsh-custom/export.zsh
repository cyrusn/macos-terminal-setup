# basic color setting
export TERM="xterm-256color"

# basic PATH and MANPATH
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
export MANPATH=/usr/local/man:$MANPATH
export MANPATH=$PATH/man:$MANPATH

# for dir_colors
# export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export MANPATH=/usr/local/opt/coreutils/libexec/gnuman:$MANPATH
test -e ~/.dir_colors && \
   eval `gdircolors -b ~/.dir_colors`

# Preferred editor for local and remote sessions
export EDITOR='vim'

# export path
export PATH=/usr/local/sbin:$PATH # for homebrew's sbin

# NODE_PATH
export NODE_PATH=$HOME/.npm-global
export PATH=$NODE_PATH/bin:$PATH
export NODE_PATH=$HOME/.npm-global/lib/node_modules:$NODE_PATH

launchctl setenv GRAPHVIZ_DOT /opt/local/bin/dot
export GRAPHVIZ_DOT

# export go path
export GOROOT=/usr/local/opt/go/libexec
export GOPATH=$HOME/golang

export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

# highlight less
### Terminal Syntax Highlighting
# Setup: "brew install highlight"
# Pipe Highlight to less
export LESSOPEN="| $(which highlight) %s --out-format xterm256 --line-numbers --quiet --force --style neon"
export LESS=" -R"
alias less='less -m -N -g -i -J --line-numbers --underline-special'
alias more='less'

export TODAY="$(gdate +%F)"