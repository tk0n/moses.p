#!/usr/bin/env bash

# Step 1: Declare Variables

snapshooter_dir=$(pwd)

# Step 2: Install nginx

if [[ -z $(command -v nginx) ]]; then
    sudo apt-get install nginx
fi

# Step 3: Move ownership to current user

sudo chown -R $USER /var/www
rm -f /var/www/html/*

# Step 4: Add nginx to ufw

if [[ $(command -v ufw) ]]; then
    sudo ufw disable
    sudo ufw allow 'Nginx HTTP'
    sudo ufw enable
fi

# Step 5: Restart nginx

sudo service nginx restart

# Step 6: Make ARK-Snapshooter executable

chmod +x ${snapshooter_dir}/snapshooter.sh

# Step 7: Create Cronjob
CRONJOB="*/15 * * * * ${snapshooter_dir}/snapshooter.sh >> ${snapshooter_dir}/snapshooter.log 2>&1"

(crontab -l | grep -v -F "${CRONJOB}" ; echo "${CRONJOB}") | crontab -
