#!/usr/bin/env bash

# ---------------------------------------------------------------------------
# This file is part of ARK Snapshooter.
#
# (c) Brian Faust <hello@brianfaust.me>
#
# For the full copyright and license information, please view the LICENSE
# file that was distributed with this source code.
# ---------------------------------------------------------------------------

setup_environment()
{
    if [ ! -f ${snapshooter_dir}/.snapshooter ]; then
        cp ${snapshooter_dir}/.snapshooter.example ${snapshooter_dir}/.snapshooter

        warning "Yikes! A default configuration has been created, next you need to run the install command to get started."
    fi

    if [[ -e ${snapshooter_dir}/.snapshooter ]]; then
        . ${snapshooter_dir}/.snapshooter
    fi
}

check_configuration()
{
    if [[ $network != 'mainnet' && $network != 'devnet' ]]; then
        abort 1 "network [$network] is invalid."
    fi
}
