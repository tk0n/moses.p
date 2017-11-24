#!/usr/bin/env bash

# Step 1: Declare Variables

snapshooter_dir=$(pwd)

# Step 2: Install nginx

if [[ -z $(command -v nginx) ]]; then
    sudo apt-get install nginx
fi

# Step 3: Make ARK-Snapshooter executable

chmod +x ${snapshooter_dir}/snapshooter.sh

# Step 4: Create Cronjob
CRONJOB="*/15 * * * * ${snapshooter_dir}/snapshooter.sh >> ${snapshooter_dir}/snapshooter.log 2>&1"

(crontab -l | grep -v -F "${CRONJOB}" ; echo "${CRONJOB}") | crontab -

# Step 5: Create nginx virtual-host

vhost='/etc/nginx/sites-available/default'
search=$(echo 'root /var/www/html;' | sed 's/\//\\\//g')
replace=$(echo 'root /home/ark/snapshots;' | sed 's/\//\\\//g')
sudo sed -i -e "s/${search}/${replace}/g" $vhost

# Step 6: Restart nginx

sudo service nginx restart
