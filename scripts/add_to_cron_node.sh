#!/bin/bash

SCRIPT_DIR=`cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P`
mkdir -p $HOME/logs

crontab -l | 
{
    echo "#crontab for $USER on $HOSTNAME"
    echo "*/60 * * * * cd $SCRIPT_DIR && ./online_check_cmix.sh >> $HOME/logs/onlone_check.log "; 
    echo "* * * * * cd $SCRIPT_DIR && ./node_check.sh >> $HOME/logs/node_check.log ";
    echo "@daily cd $SCRIPT_DIR && ./staking-payouts.sh >> $HOME/logs/payout.log ";
} | crontab -

crontab -l
