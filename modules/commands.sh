#!/usr/bin/env bash

# ---------------------------------------------------------------------------
# This file is part of ARK Moses.
#
# (c) Brian Faust <hello@brianfaust.me>
#
# For the full copyright and license information, please view the LICENSE
# file that was distributed with this source code.
# ---------------------------------------------------------------------------

moses_start()
{
    heading "Starting moses..."
    pm2 start ${moses_dir}/apps.json >> $moses_log 2>&1
    success "Start complete!"
}

moses_stop()
{
    heading "Stopping moses..."
    pm2 stop ${moses_dir}/apps.json >> $moses_log 2>&1
    success "Stop complete!"
}

moses_restart()
{
    heading "Restarting moses..."
    pm2 restart ${moses_dir}/apps.json >> $moses_log 2>&1
    success "Restart complete!"
}

moses_reload()
{
    heading "Reloading moses..."
    pm2 reload ${moses_dir}/apps.json >> $moses_log 2>&1
    success "Reload complete!"
}

moses_delete()
{
    heading "Deleting moses..."
    pm2 delete ${moses_dir}/apps.json >> $moses_log 2>&1
    success "Delete complete!"
}

moses_config()
{
    nano ${moses_dir}/.moses
}

moses_tail()
{
    if [ ! -e $moses_log ]; then
        touch $moses_log
    fi

    tail -f $moses_log
}

moses_update()
{
    local remote_version=$(git rev-parse origin/master)
    local local_version=$(git rev-parse HEAD)

    if [[ $remote_version == $local_version ]]; then
        info 'You are already using the latest version of ARK Moses.'
    else
        read -p 'An update for ARK Moses is available, do you want to install it? [y/N] :' choice

        if [[ $choice =~ ^(yes|y) ]]; then
            heading 'Updating ARK Moses...'
            moses_stop
            git reset --hard >> $moses_log 2>&1
            git pull >> $moses_log 2>&1
            moses_start
            success 'Update OK!'
        else
            abort 1 "Aborting..."
        fi
    fi
}

moses_alias()
{
    heading "Installing alias..."
    echo "alias moses='bash ${moses_dir}/moses.sh'" | tee -a ~/.bashrc
    source ${HOME}/.bashrc
    success "Installation complete!"
}

moses_version()
{
    echo $(git rev-parse HEAD)
}

moses_help()
{
    cat << EOF
Usage: $moses [options]
options:
    help                      Show this help.
    version                   Show the installed version.
    start                     Start the moses process.
    stop                      Stop the moses process.
    restart                   Restart the moses process.
    reload                    Reload the moses process.
    dump                      Create a new snapshot.
    schedule                  Create a new snapshot for the specified schedule.
    install                   Install moses.
    uninstall                 Uninstall moses.
    update                    Update moses.
    config                    Configure moses.
    alias                     Create a bash alias for moses.
    log                       Show the moses log.
EOF
}
