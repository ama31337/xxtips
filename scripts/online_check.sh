#!/bin/bash

# sript to restart XX node
# to execute systemctl add nopasswd execution for sudo users:
# sudo vim /etc/sudoers
# %sudo  ALL=(ALL) NOPASSWD: ALL

SCRIPT_DIR=`cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P`
ONLINE_CHECK=$(curl -s https://dashboard.xx.network/nodes/-OweYumaMwgvGQ21WTlOH2zUxRc3T_MyfOMZUzdKSZ4C | grep -o "offline")

if [[ -z "$ONLINE_CHECK" ]]
then
    echo "online"
else
    echo "offline"
    sudo systemctl restart xxnetwork-node.service
    sudo systemctl restart xxnetwork-gateway.service
    "${SCRIPT_DIR}/Send_msg_toTelBot.sh" "$HOSTNAME inform you:" "XX node was offline and restarted now"  2>&1 > /dev/null
fi
