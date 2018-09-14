function fix {
    FILENAME=/tmp/fix.$USER
    ag -sw "$1" > $FILENAME
    if [ -s $FILENAME ]
    then
        vim -q $FILENAME -c copen -c "/\<$1\>"
    else
        echo $1: not found
    fi
}
