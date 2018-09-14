BASH_COMPLETION_PATHS="
    /etc/bash_completion
    /usr/local/etc/bash_completion
"

for P in $BASH_COMPLETION_PATHS
do
    if [ -f $P ]
    then
        source $P
    fi
done
