#!/bin/bash

# sript to restart XX node
# to execute systemctl add nopasswd execution for sudo users:
# sudo vim /etc/sudoers
# %sudo  ALL=(ALL) NOPASSWD: ALL

# change nodeid, if you've "/" in nodeid, replace with "_"
NODE_DASHBOARD_ID="lux8"
SCRIPT_DIR=`cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P`
#ONLINE_CHECK=$(curl -s https://dashboard.xx.network/nodes/$NODE_DASHBOARD_ID | grep -o "offline")
API_DATA=$(curl -sX GET "https://dashboard-api.xx.network/v1/nodes/${NODE_DASHBOARD_ID}" -H  "accept: application/json; charset=utf-8")
ONLINE_CHECK=$(echo $API_DATA | jq -r .node.status)

echo `date`

if [[ "$ONLINE_CHECK" = "online" ]]
then
     echo "XX Cmix is online"
else
    echo "XX Cmix is NOT ONLINE"
    "${SCRIPT_DIR}/../Send_msg_toTelBot.sh" "$HOSTNAME inform you:" "ALARM! XX cmix NOT ONLINE, check your node"  2>&1 > /dev/null
#    sudo systemctl restart xxnetwork-cmix.service
fi
