#!/bin/bash

# sript to restart XX node
# to execute systemctl add nopasswd execution for sudo users:
# sudo vim /etc/sudoers
# %sudo  ALL=(ALL) NOPASSWD: ALL

SCRIPT_DIR=`cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P`
XXNODE_PID=`ps -e | grep xxnetwork-node | grep defunct`

if [ -z "$XXNODE_PID" ]; then
    echo "`date` XX node working ..."
else
    echo "`date` ALARM, need to restart node"
    sudo systemctl stop xxnetwork-node.service
    sudo systemctl start xxnetwork-node.service
    "${SCRIPT_DIR}/Send_msg_toTelBot.sh" "$HOSTNAME inform you:" "XX node defunct and restarted now"  2>&1 > /dev/null
fi

