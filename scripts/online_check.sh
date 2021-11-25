#!/bin/bash

# sript to restart XX node
# to execute systemctl add nopasswd execution for sudo users:
# sudo vim /etc/sudoers
# %sudo  ALL=(ALL) NOPASSWD: ALL

NODE_DASHBOARD_ID="xxx"
SCRIPT_DIR=`cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P`
API_DATA=$(curl -sX GET "https://dashboard-api.xx.network/v1/nodes/$NODE_DASHBOARD_ID" -H  "accept: application/json; charset=utf-8")
ONLINE_CHECK=$(echo $API_DATA | jq -r .node.status)

if [[ -z "$ONLINE_CHECK" ]]
then
    echo "offline"
    #sudo systemctl restart xxnetwork-node.service
    #sudo systemctl restart xxnetwork-gateway.service
    "${SCRIPT_DIR}/../Send_msg_toTelBot.sh" "$HOSTNAME inform you:" "check your XX node"  2>&1 > /dev/null
    echo "online"
else
    echo "online"
fi
