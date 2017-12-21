#!/usr/bin/env bash

# ---------------------------------------------------------------------------
# This file is part of moses.
#
# (c) Brian Faust <hello@brianfaust.me>
#
# For the full copyright and license information, please view the LICENSE
# file that was distributed with this source code.
# ---------------------------------------------------------------------------

moses_install()
{
    heading "Starting Installation..."

    if [ -f ${moses_dir}/.moses ]; then
        info "Configuration already exists..."
    else
        heading "Installing Configuration..."
        cp ${moses_dir}/.moses.example ${moses_dir}/.moses;
        success "Installation OK."
    fi

    if [[ -z $(command -v nginx) ]]; then
        heading "Installing nginx..."
        sudo apt-get install nginx -y
        sudo chown -R $USER /var/www
        rm -f /var/www/html/*
        sudo sed -i 's/index index.html index.htm index.nginx-debian.html;/index manifest;/g' /etc/nginx/sites-available/default
        success "Installation OK."
    else
        info "nginx already exists..."
    fi

    if [[ $(command -v ufw) ]]; then
        heading "Installing ufw rules..."
        sudo ufw disable
        sudo ufw allow 'Nginx HTTP'
        sudo ufw enable
        success "Installation OK."
    else
        info "ufw doesn't exists..."
    fi

    if [[ -z $(command -v jq) ]]; then
        heading "Installing jq..."
        sudo apt-get -qq install jq >> $moses_log 2>&1
        success "Installation OK."
    else
        info "jq already exists..."
    fi

    if [[ -z $(command -v pm2) ]]; then
        heading "Installing pm2..."
        npm install pm2 -g >> $moses_log 2>&1
        success "Installation OK."
    else
        info "pm2 already exists..."
    fi
    
    success "Installation complete!"
}
