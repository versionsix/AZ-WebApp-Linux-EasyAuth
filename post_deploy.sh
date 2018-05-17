#!/bin/bash

# Since azure uses a weird way of pulling a deployment,
# and when using a container you can't specify any post
# deployment at all for some unknow reason this script
# gets triggered at container boot and triggers if the
# `hostingstart.html` is still present. This file is 
# present at the moment of writing (17/05/2018) after
# deployment.
# As a fail-safe fallback might azure change their setup
# in the future we also touch `/home/site/wwwroot/.deployed`
# to prevent doing running the script a second time.

file2="/home/site/wwwroot/.deployed"

rm /home/site/wwwroot/hostingstart.html

if [ ! -f "$file2" ]
then
    echo "New deployment, running post deployment script"
    touch "$file2"
    cp -a /code/. /home/site/wwwroot/
fi

