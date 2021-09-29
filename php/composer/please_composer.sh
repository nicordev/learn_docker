#! /bin/bash

EXIT_CODE_BYE=187
#SCRIPT_NAME=$(basename $0)
#SCRIPT_DIRECTORY=.
SCRIPT_NAME=$(basename $BASH_SOURCE)
SCRIPT_DIRECTORY=$(dirname $BASH_SOURCE)
CONTAINER_APP_DIRECTORY="/var/www/html"

build() {
    docker build -t my_composer $SCRIPT_DIRECTORY
}

bash() {
    docker run -it --volume=$PWD:$CONTAINER_APP_DIRECTORY my_composer:latest bash
}

composerInstall() {
    docker run -it --volume=$PWD:$CONTAINER_APP_DIRECTORY my_composer:latest composer install
}

_handleExit() {
    if [ $? == $EXIT_CODE_BYE ]; then
        echo "Have a nice day!"
    fi
}

# Display the source code of this file
howItWorks() {
    cat $0
}

# List all functions that do not begin with an underscore _
_listAvailableFunctions() {
    cat $0 | grep -E '^[a-z]+[a-zA-Z0-9_]*\(\) \{$' | sed 's#() {$##' | sort
}

if [ $# -eq 0 ]; then
    _listAvailableFunctions
    exit
fi

trap _handleExit exit err

$@
