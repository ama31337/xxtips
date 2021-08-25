#!/bin/bash

# sript to restart XX node
# to execute systemctl add nopasswd execution for sudo users:
# sudo vim /etc/sudoers
# %sudo  ALL=(ALL) NOPASSWD: ALL

SCRIPT_DIR=`cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P`
gateway_check=$(ps -e | grep xxnetwork-gatew)

echo `date`

if [[ -z "$gateway_check" ]]
then
    echo "XX gateway offline"
    sudo systemctl restart xxnetwork-gateway.service
    "${SCRIPT_DIR}/../Send_msg_toTelBot.sh" "$HOSTNAME inform you:" "XX gateway was offline and restarted now"  2>&1 > /dev/null
    echo "online"
else
    echo "online"
fi

