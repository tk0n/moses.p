#!/usr/bin/env bash

# Step 1: Declare Variables

snapshooter_dir=$(locate -b '\ARK-Snapshooter')

# Step 2: Install nginx

if [[ -z $(command -v nginx) ]]; then
    sudo apt-get install nginx
fi

# Step 3: Make ARK-Snapshooter executable

chmod +x ${snapshooter_dir}/snapshooter.sh

# Step 4: Create Cronjob
croncmd="${snapshooter_dir}/snapshooter.sh >> ${snapshooter_dir}/snapshooter.log 2>&1"
cronjob="*/15 * * * * $croncmd"

(crontab -l | grep -v -F "$croncmd" ; echo "$cronjob") | crontab -

# Step 5: Create nginx virtual-host

vhost='/etc/nginx/sites-available/default'
search='root /var/www/html;'
replace='root /home/ark/snapshots;'
sed -i "" "s|${search}|${replace}|g" $vhost

# Step 6: Restart nginx

sudo service nginx restart
