### xxtips
Scripts for automate XX node and gateway restarts 

### Installation
 1. Create telegram bot and get Api Token (via @BotFather in telegram)
 2. Send to your new bot command /start
 3. Clone repo to your node and gateway
```sh
cd $HOME && git clone -v https://github.com/ama31337/xxtips.git
```
 4. Edit Send_msg_toTelBot.sh with your bot API and your telegram id on both machines
 5. Edit online_check.sh with your node URL
 6. Add your user to sudoers to execute node restart w/o password prompt
```
sudo echo "$USER  ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
```
 7. Run script to create crontab tasks on node
```
cd $HOME/xxtips/scripts && ./add_to_cron_node.sh
```
and on gateway
```
cd $HOME/xxtips/scripts && ./add_to_cron_gateway.sh
```
 8. Check crontab
```
crontab -l
```
 9. Done
