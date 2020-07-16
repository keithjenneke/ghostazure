#!/bin/bash
exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>/var/log/install-ghost-log.out 2>&1
echo "#### Start install-ghost.sh ####"
PWD=bash pwd
ID=bash id
echo "#### working directory $PWD ####"

# server fqdn
URL="http://"$1
echo "#### URL: $URL ####"

# create random password
PASSWDDB="$(openssl rand -base64 12)"
#PASSWDDB=$2
echo "#### MYSQL Password: $PASSWDDB ####"

# update packages
echo "#### upddate and upgrade packcages ####"
sudo apt-get update -y && sudo apt-get upgrade -y && sudo apt autoremove -y && sudo apt -f install

# install mysql and configure mysql
echo "#### install and configure mysql ####"
sudo apt-get update
sudo apt-get install mysql-server -y
sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '${PASSWDDB}';"

# install nginx 
echo "#### install nginx ####"
sudo apt-get install nginx -y
sudo ufw allow 'Nginx Full'

# install nodejs 
echo "#### install nodejs ####"
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash
sudo apt-get install -y nodejs

# install ghost-cli
echo "#### install ghost-cli ####"
sudo npm install ghost-cli@latest -g

sudo mkdir -p /var/www/ghost && sudo chown ghostuser:ghostuser /var/www/ghost && sudo chmod 775 /var/www/ghost

# call ghost-install.sh script
sudo /var/lib/waagent/custom-script/download/0/ghost-install.sh $URL $PASSWDDB

echo "#### End install-ghost.sh ####"
exit 0