#!/usr/bin/env bash

# ---------------------------------------------------------------------------
# This file is part of ARK Snapshooter.
#
# (c) Brian Faust <hello@brianfaust.me>
#
# For the full copyright and license information, please view the LICENSE
# file that was distributed with this source code.
# ---------------------------------------------------------------------------

snapshooter_install()
{
    heading "Starting Installation..."

    if [ -f ${snapshooter_dir}/.snapshooter ]; then
        info "Configuration already exists..."
    else
        heading "Installing Configuration..."
        cp ${snapshooter_dir}/.snapshooter.example ${snapshooter_dir}/.snapshooter;
        success "Installation OK."
    fi

    if [[ -z $(command -v nginx) ]]; then
        heading "Installing nginx..."
        sudo apt-get install nginx -y
        sudo chown -R $USER /var/www
        rm -f /var/www/html/*
        success "Installation OK."
    else
        info "nginx already exists..."
    fi

    if [[ $(command -v ufw) ]]; then
        sudo ufw disable
        sudo ufw allow 'Nginx HTTP'
        sudo ufw enable
    else
        info "ufw doesn't exists..."
    fi

    heading "Installing Crontab..."
    CRONJOB="${snapshot_interval} ${snapshooter_dir}/snapshooter.sh >> ${snapshooter_dir}/snapshooter.log 2>&1"
    (crontab -l | grep -v -F "${CRONJOB}" ; echo "${CRONJOB}") | crontab -
    success "Installation OK."

    heading "Installing ARK Snapshooter..."
    chmod +x ${snapshooter_dir}/snapshooter.sh
    success "Installation OK."

    success "Installation complete!"
}
