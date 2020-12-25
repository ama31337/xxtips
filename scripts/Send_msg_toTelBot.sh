#!/bin/bash

#test2
#mahakali
telegram_bot_token="1300378017:AAEoicYcVG1KAPv2ZyHWmJq1oJVQNGPyD5Q"
#FreeTON
#telegram_bot_token="1437809203:AAHXdmGCOijYe4Ht0SaxjXkTgUTl_eWkKHw"
#GPUpower
#telegram_bot_token="1485822871:AAHN3PrSbJOxENgdUsJ_4M_CQKrBYC30UYw"

#main bots chat
telegram_chat_id="-466217161"
#freeton bot chat
#telegram_chat_id="-1001441535977"

Title="$1"
Message="$2"

curl -s \
 --data parse_mode=HTML \
 --data chat_id=${telegram_chat_id} \
 --data text="<b>${Title}</b>%0A${Message}" \
 --request POST https://api.telegram.org/bot${telegram_bot_token}/sendMessage
