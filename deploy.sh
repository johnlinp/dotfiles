#!/bin/bash

entries=`ls | grep -v '\.sh'`
for entry in $entries
do
    files=`find $entry -type f`
    for file in $files
    do
        exist=`test -e ~/.$file && echo yes`
        soft_link=`test -L ~/.$file && echo yes`
        same_file=`test $file -ef ~/.$file && echo yes`

        if [ "$same_file" == "yes" ]
        then
            continue
        fi

        if [ "$exist" == "yes" ]
        then
            if [ "$soft_link" == "yes" ]
            then
                rm -f ~/.$file
                ln -s `pwd`/$file ~/.$file
                echo deployed .$file
            else
                read -p "rewrite dotfile .$file? [y/N] " rewrite
                if [ "$rewrite" == "y" ] || [ "$rewrite" == "Y" ] || [ "$rewrite" == "yes" ] || [ "$rewrite" == "YES" ]
                then
                    rm -f ~/.$file
                    ln -s `pwd`/$file ~/.$file
                    echo deployed .$file
                fi
            fi
        else
            ln -s `pwd`/$file ~/.$file
            echo deployed .$file
        fi
    done
done

