#!/bin/bash

SCRIPT_DIR=`cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P`
mkdir -p $HOME/logs

crontab -l | 
{
    echo "#crontab for $USER on $HOSTNAME"
    #echo "0 * * * * cd $SCRIPT_DIR && ./node_check.sh >> $HOME/logs/check_sync.log "; 
    echo "*/5 * * * * cd $SCRIPT_DIR && ./gate_check.sh >> $HOME/logs/gateway_check.log ";
    echo "*/15 * * * * cd $SCRIPT_DIR && ./online_check_and_restart_gateway.sh >> $HOME/logs/gateway_check.log";
} | crontab -

crontab -l
