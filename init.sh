#!/bin/bash
set -e

echo "Starting SSH ..."
service ssh start

# Get environment variables to show up in SSH session
eval $(printenv | awk -F= '{print "export " $1"="$2 }' >> /etc/profile)

# Load apache2 envvars 
source /etc/apache2/envvars

file1="/home/site/wwwroot/hostingstart.html"
if [ -f "$file1" ]
then
    /usr/local/bin/post_deploy.sh
fi

apachectl -DFOREGROUND