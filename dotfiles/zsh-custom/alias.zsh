alias zshrc='$EDITOR ~/.zshrc' # Quick access to the ~/.zshrc file

# Some shortcuts for different directory listings
alias ls='gls -ahNF --group-directories-first --color=auto --time-style=+"%e/%m/%y %T"' # classify files in colour

alias la='ls -go'
alias l='ls'

alias ..='cd ..'
alias ...='cd ../../../'
alias ....='cd ../../../../'
alias .....='cd ../../../../../'
alias .1='cd ../'
alias .2='cd ../../'
alias .3='cd ../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../..'
alias .6='cd ../../../../../..'

alias tsh='trash'
alias mkdir='mkdir -p'
# alias mongod='mongod --dbpath=$HOME/Dropbox/db'
alias tree='tree -L 1'
alias ql='qlmanage -p'
alias pkill='pkill -9'

## do not delete / or prompt if deleting more than 3 files at a time
alias rm="rm -i"
alias cp='cp -i'
alias mv='mv -i'

# Default to human readable figures
alias df='df -h'
alias du='du -ch'

function copydir {
  pwd | sed -E 's/([ |&])/\\\1/g' | tr -d "\r\n"  | pbcopy
}

# dump $PATH, in a hunam readable way
alias paths='echo -e ${PATH//:/\\n} | cat -n'
alias top='which htop > /dev/null && htop || top'

#------
# grep
#------
alias grep='grep --color'                     # show differences in colour
alias egrep='egrep --color=auto'              # show differences in colour
alias fgrep='fgrep --color=auto'              # show differences in colour
alias cgrep='find . \( -type f -o -type l \) -iname "*\.c*" -print0 | xargs -0 grep --color -n "$@"'
alias hgrep='find . \( -type f -o -type l \) -iname "*\.h*" -print0 | xargs -0 grep --color -n "$@"'
alias jgrep='find . \( -type f -o -type l \) -iname "*\.java" -print0 | xargs -0 grep --color -n "$@"'
alias jsgrep='find . \( -type f -o -type l \) -iname "*\.js" -print0 | xargs -0 grep --color -n "$@"'
alias mdgrep='find . \( -type f -o -type l \) -iname "*\.md" -print0 | xargs -0 grep --color -n "$@"'
alias mkgrep='find . \( -type f -o -type l \) -iname "*\.mk" -print0 | xargs -0 grep --color -n "$@"'
alias pygrep='find . \( -type f -o -type l \) -iname "*\.py" -print0 | xargs -0 grep --color -n "$@"'
alias shgrep='find . \( -type f -o -type l \) -iname "*.sh" -print0 | xargs -0 grep --color -in "$@"'
alias txtgrep='find . \( -type f -o -type l \) -iname "*\.txt" -print0 | xargs -0 grep --color -n "$@"'
alias xmlgrep='find . \( -type f -o -type l \) -iname "*\.xml" -print0 | xargs -0 grep --color -n "$@"'
alias dbgrep='find . \( -type f -o -type l \) -iname "*.json" ! -iname "*.info.json" -print0 | xargs -0 grep --color -in "$@"'

# git
alias gdl='git difftool'
alias gdi='git diff -w'
alias gst='git status'
alias gci='git commit'
alias glo='git log'
alias gl1='git log --oneline'
alias glp='git log -p'

# shortcut
alias desktop='cd $HOME/Desktop'
alias nas='cd $HOME/Dropbox/NASBackup'
alias commonroom='cd $HOME/Dropbox/commonroom'
alias dropbox='cd Dropbox'

# Application
## the_platinum_searcher
alias pt='pt -i'

## download youtube
alias youtube-dl='youtube-dl -o "~/Desktop/%(title)s.%(ext)s" "$@"'
alias audio-dl='youtube-dl --extract-audio --audio-quality=0'

## brew and brew cask
alias brews='brew search'
alias brewi='brew install'
alias brewui='brew uninstall'
alias brewu='brew update && brew outdated && brew upgrade && brew cleanup'
alias cask='brew cask'
alias casks='brew cask search'
alias caski='brew cask install'
alias caskui='brew cask uninstall'
alias caskz='brew cask zap'
alias casku='brew cask update && brew cask cleanup'
alias puml='plantuml -gui'

alias update="sudo softwareupdate --install --all --background"

# colorize less
function pless () {
  colorize "$1" | less -R
}

# colorize cat
alias pcat="colorize"

# date
alias date="gdate"

alias blog="cd /Users/CyrusN/Dropbox/HugoBlog && open http://localhost:1313/ && hugo serve -D"

alias crontab="VIM_CRONTAB=true crontab"

alias t="todo.sh"