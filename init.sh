#!/bin/bash
set -e

echo "Starting SSH ..."
service ssh start

# Load apache2 envvars 
source /etc/apache2/envvars
apachectl -DFOREGROUND