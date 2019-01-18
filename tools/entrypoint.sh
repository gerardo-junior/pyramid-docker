#!/bin/sh
sudo chgrp -Rf $USER $WORKDIR

if [ -e "$(pwd)/requirements.txt" ]; then
    pip install --no-cache-dir -r requirements.txt --user
fi

export PATH="$PATH:/home/$USER/.local/bin"

if [ ! -z "$1" ]; then
    if [ -z "$(which -- $1)" ]; then
        python "$@"
    else
        exec "$@"
    fi
elif [ -d "$(pwd)/public" ]; then
    echo -e "\n" \
            "==============================================================\n" \
            "==============================================================\n" \
            "==================== OPEN IN YOUR BROWSER ====================\n" \
            "==============================================================\n" \
            "==============================================================\n" 
 
    # Apache gets grumpy about PID files pre-existing
    sudo sh -c 'pserve development.ini --reload'

else 

    echo "/public folder not found."
    exit 1

fi