# aliases
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias ls='ls --color=auto'
alias ll='ls -alF'
alias grep='grep --color=auto'
alias du='du -sh'
alias pingg='ping 8.8.8.8'
alias shutup='dbus-send --system --print-reply --dest=org.freedesktop.ConsoleKit /org/freedesktop/ConsoleKit/Manager org.freedesktop.ConsoleKit.Manager.Stop'
alias pacman='pacman --color=auto'
alias vi='vim'
alias index='(ctags -R --sort=foldcase .; mkid)'

# auto completion
if [ -f /etc/bash_completion ]
then
    . /etc/bash_completion
fi

# some more binaries and scripts
PATH=$PATH:~/bin

# git branch
function git_branch {
    REF=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
    [ "$?" == "0" ] && echo " ($REF)"
}

# simple prompt
PS1='\u@\[\033[01;34m\]\h\[\033[00m\]:\W$(git_branch)\$ '

# android vm development
function ad {
    cd ~/coding/leisure/android/
    . build/envsetup.sh
    lunch aosp_arm-eng
}

# latex
function onetex {
    if [ "$1" != "" ]
    then
        filename=$1
    else
        filename=main
    fi
    pdflatex $filename
    bibtex $filename
    pdflatex $filename
    pdflatex $filename
}

# ack + vim quick fix
function fix {
    FILENAME=/tmp/fix.$USER
    ag -sw $1 > $FILENAME
    if [ -s $FILENAME ]
    then
        vim -q $FILENAME -c copen -c "/\<$1\>"
    else
        echo $1: not found
    fi
}
