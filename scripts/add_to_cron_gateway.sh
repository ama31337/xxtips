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
    #echo "0 * * * * cd $SCRIPT_DIR && ./node_check.sh >> $HOME/logs/check_sync.log "; 
    echo "* * * * * cd $SCRIPT_DIR && ./gate_check.sh >> $HOME/logs/gateway_check.log ";
} | crontab -

crontab -l
