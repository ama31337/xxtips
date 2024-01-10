#!/bin/bash

# sript to restart XX node
# to execute systemctl add nopasswd execution for sudo users:
# sudo vim /etc/sudoers
# %sudo  ALL=(ALL) NOPASSWD: ALL

# change nodeid, if you've "/" in nodeid, replace with "_"
NODE_DASHBOARD_ID="8HOm6D4CgzOukBBgvy_wyillmi_Jia7hsHTPouUjEx0C"
SCRIPT_DIR=`cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P`
ALARM=0
TEST=0

function api_check {
        API_DATA=$(curl -sX GET "https://dashboard-api.xx.network/v1/nodes/${NODE_DASHBOARD_ID}" -H  "accept: application/json; charset=utf-8")
        ONLINE_CHECK=$(echo $API_DATA | jq -r .node.status)
        echo `date`
        if [[ "$ONLINE_CHECK" = "online" ]]
        then
                echo "XX Cmix is online"
                TEST=$(($TEST + 1))
        else
                ALARM=$(($ALARM + 1))
        fi
}


function tg_alarm {
        echo "XX Cmix is NOT ONLINE, xx-gateway will be restarted"
        "${SCRIPT_DIR}/../Send_msg_toTelBot.sh" "$HOSTNAME inform you:" "ALARM! XX cmix NOT ONLINE, check your node"  2>&1 > /dev/null
}

function restart {
        sudo systemctl restart xxnetwork-gateway.service
}

api_check
sleep 30
api_check

if [[ $TEST = 2 ]]
then
        echo " test passed 2 times OK"
else
        echo " test NOT passed 2 times"
fi

if [[ $ALARM = 2 ]]
then
        echo "alarm"
	tg_alarm 
        restart
else
        echo "ok"
fi

