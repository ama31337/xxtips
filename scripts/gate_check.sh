#!/bin/bash

# sript to restart XX node
# to execute systemctl add nopasswd execution for sudo users:
# sudo vim /etc/sudoers
# %sudo  ALL=(ALL) NOPASSWD: ALL

SCRIPT_DIR=`cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P`
node_check=$(sudo systemctl status xxnetwork-chain.service | grep running)
gate_check=$(sudo systemctl status xxnetwork-gateway.service | grep running)
node_check_ps=$(ps -e | grep xxnetwork-chain)
gate_check_ps=$(ps -e | grep xxnetwork-gate)

echo `date`

if [[ -z "$node_check" ]]
then
    echo "XX node offline"
    sudo systemctl restart xxnetwork-chain.service
    "${SCRIPT_DIR}/../Send_msg_toTelBot.sh" "$HOSTNAME inform you:" "XX node was offline and restarted now"  2>&1 > /dev/null
else
    echo "online"
fi

if [[ -z "$gate_check" ]]
then
    echo "XX gate offline"
    sudo systemctl restart xxnetwork-gateway.service
    "${SCRIPT_DIR}/../Send_msg_toTelBot.sh" "$HOSTNAME inform you:" "XX gateway was offline and restarted now"  2>&1 > /dev/null
else
    echo "online"
fi

if [[ -z "$node_check_ps" ]]
then
    echo "XX node process offline"
    sudo systemctl restart xxnetwork-chain.service
    "${SCRIPT_DIR}/../Send_msg_toTelBot.sh" "$HOSTNAME inform you:" "XX node process was offline and restarted now"  2>&1 > /dev/null
else
    echo "online"
fi

if [[ -z "$gate_check_ps" ]]
then
    echo "XX gate offline"
    sudo systemctl restart xxnetwork-gateway.service
    "${SCRIPT_DIR}/../Send_msg_toTelBot.sh" "$HOSTNAME inform you:" "XX gateway process was offline and restarted now"  2>&1 > /dev/null
else
    echo "online"
fi
