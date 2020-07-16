#!/bin/bash
exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>/var/log/ghost-install-log.out 2>&1
echo "#### Start ghost-install.sh ####"

# server fqdn
URL=$1
echo "#### URL: $URL ####"

PASSWDDB=$2
echo "#### PASSWDDB: $PASSWDDB ####"

# install ghost
echo "#### install ghost ####"
sudo -H -u ghostuser bash -c "cd /var/www/ghost && ghost install --no-prompt --url $URL --db mysql --dbhost localhost --dbuser root --dbpass $PASSWDDB --dbname ghost_prod --setup-nginx --process systemd --start --enable"
echo "#### End ghost-install.sh ####"
exit 0