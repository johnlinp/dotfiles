export BASH_COMPLETION_COMPAT_DIR=/usr/local/etc/bash_completion.d

BASH_COMPLETION_PATHS="
    /etc/bash_completion
    /usr/local/etc/profile.d/bash_completion.sh
"

for P in $BASH_COMPLETION_PATHS
do
    if [ -f $P ]
    then
        source $P
    fi
done
