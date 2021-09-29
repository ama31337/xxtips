#!/bin/bash

# sript to restart XX node
# to execute systemctl add nopasswd execution for sudo users:
# sudo vim /etc/sudoers
# %sudo  ALL=(ALL) NOPASSWD: ALL

NODE_DASHBOARD_ID="t5o1I75y5hAXaN+PqyP2rPCr+sttZckX8SjiqxeGEeQC"
SCRIPT_DIR=`cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P`
#ONLINE_CHECK=$(curl -s https://dashboard.xx.network/nodes/-OweYumaMwgvGQ21WTlOH2zUxRc3T_MyfOMZUzdKSZ4C | grep -o "offline")
API_DATA=$(curl -sX GET "https://protonet-api.xx.network/v1/nodes/$NODE_DASHBOARD_ID" -H  "accept: application/json; charset=utf-8")
ONLINE_CHECK=$(echo $API_DATA | jq -r .node.status)

echo `date`

if [[ "$ONLINE_CHECK" = "online" ]]
then
     echo "XX Cmix is online"
else
    echo "XX Cmix is NOT ONLINE"
    "${SCRIPT_DIR}/../Send_msg_toTelBot.sh" "$HOSTNAME inform you:" "XX cmix NOT ONLINE and restarted now"  2>&1 > /dev/null
    sudo systemctl restart xxnetwork-cmix.service
fi
