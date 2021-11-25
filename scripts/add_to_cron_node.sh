#!/bin/bash

SCRIPT_DIR=`cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P`
mkdir -p $HOME/logs

pkgs='jq'
if ! dpkg -s $pkgs >/dev/null 2>&1; then
    sudo apt-get update
    sudo apt-get install -y $pkgs
fi

crontab -l | 
{
    echo "#crontab for $USER on $HOSTNAME"
    echo "*/5 * * * * cd $SCRIPT_DIR && ./online_check.sh >> $HOME/logs/onlone_check.log "; 
    echo "* * * * * cd $SCRIPT_DIR && ./node_check.sh >> $HOME/logs/node_check.log ";
} | crontab -

crontab -l
