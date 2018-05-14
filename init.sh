#!/bin/bash
set -e
cat >/etc/motd <<EOL 
A P P   S E R V I C E   O N   L I N U X
Documentation: http://aka.ms/webapp-linux
PHP quickstart: https://aka.ms/php-qs
EOL

# Get environment variables to show up in SSH session
eval $(printenv | awk -F= '{print "export " $1"="$2 }' >> /etc/profile)

echo "Starting SSH ..."
service ssh start

sed -i "s/{PORT}/$PORT/g" /etc/apache2/apache2.conf
mkdir /var/lock/apache2
mkdir /var/run/apache2

# Load apache2 envvars 
source /etc/apache2/envvars
/usr/sbin/apache2ctl -DFOREGROUND