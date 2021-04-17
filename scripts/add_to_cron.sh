#!/bin/bash

SCRIPT_DIR=`cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P`
mkdir -p $HOME/logs

crontab -l | {
    echo "#XX network cronjobs for $USER on $HOSTNAME" 
    echo "0 * * * * cd $SCRIPT_DIR && ./node_check.sh >> $HOME/logs/node_check.log ";
    echo "*/15 * * * * cd $SCRIPT_DIR && ./online_check.sh >> $HOME/logs/./online_check.log ";
} | crontab -
