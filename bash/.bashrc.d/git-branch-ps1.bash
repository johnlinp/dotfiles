function git_branch {
    REF=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
    [ "$?" == "0" ] && echo " ($REF)"
}

PS1='\u@\[\033[01;34m\]\h\[\033[00m\]:\W$(git_branch)\$ '
