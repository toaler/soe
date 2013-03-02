#!/bin/bash

function create_directory {
    if [ ! -d "$1" ]; then
        mkdir $1
        if [ $? -ne 0 ]; then
            echo "Creating directory $1 failed."
            exit 1
        fi 
        echo "Created directory $1"
    else
        echo "Directory $1 exists, no need to create"
    fi
}

function install_script {
    if [ ! -e $1 ]; then 
        echo "install_script failed, source file $1 doesn't exist, existing";
        exit 1;
    fi

    cp -p $1 $2
    if [ ! -e $2 ]; then
        echo "File $1 failed to copy to $2, exiting.";
        exit 1;
    fi
    chmod 755 $2
    echo "Installed $1 to $2."
}

echo "Starting installation."
echo ""
echo "Creating directories"

create_directory $HOME/bin
create_directory $HOME/logs

echo
echo "Installing scripts"

install_script scripts/bashrc.sh $HOME/.bashrc
install_script scripts/chrome.sh $HOME/bin/chrome
