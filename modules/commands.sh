#!/usr/bin/env bash

# ---------------------------------------------------------------------------
# This file is part of ARK Snapshooter.
#
# (c) Brian Faust <hello@brianfaust.me>
#
# For the full copyright and license information, please view the LICENSE
# file that was distributed with this source code.
# ---------------------------------------------------------------------------

snapshooter_config()
{
    nano ${snapshooter_dir}/.snapshooter
}

snapshooter_tail()
{
    if [ ! -e $snapshooter_log ]; then
        touch $snapshooter_log
    fi

    tail -f $snapshooter_log
}

snapshooter_update()
{
    local remote_version=$(git rev-parse origin/master)
    local local_version=$(git rev-parse HEAD)

    if [[ $remote_version == $local_version ]]; then
        info 'You are already using the latest version of ARK Snapshooter.'
    else
        read -p 'An update for ARK Snapshooter is available, do you want to install it? [y/N] :' choice

        if [[ $choice =~ ^(yes|y) ]]; then
            heading 'Updating ARK Snapshooter...'
            git pull
            success 'Update OK!'
        else
            abort 1 "Aborting..."
        fi
    fi
}

snapshooter_alias()
{
    heading "Installing alias..."
    echo "alias snapshooter='bash ${snapshooter_dir}/snapshooter.sh'" | tee -a ~/.bashrc
    source ${HOME}/.bashrc
    success "Installation complete!"
}

snapshooter_version()
{
    echo $(git rev-parse HEAD)
}

snapshooter_help()
{
    cat << EOF
Usage: $snapshooter [options]
options:
    help                      Show this help.
    version                   Show the installed version.
    install                   Install snapshooter.
    uninstall                 Uninstall snapshooter.
    update                    Update snapshooter.
    config                    Configure snapshooter.
    log                       Show the snapshooter log.
EOF
}
