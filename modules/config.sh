#!/usr/bin/env bash

# ---------------------------------------------------------------------------
# This file is part of moses.
#
# (c) Brian Faust <hello@brianfaust.me>
#
# For the full copyright and license information, please view the LICENSE
# file that was distributed with this source code.
# ---------------------------------------------------------------------------

setup_environment()
{
    if [ ! -f ${moses_dir}/.moses ]; then
        cp ${moses_dir}/.moses.example ${moses_dir}/.moses

        warning "Yikes! A default configuration has been created, next you need to run the install command to get started."
    fi

    if [[ -e ${moses_dir}/.moses ]]; then
        . ${moses_dir}/.moses
    fi
}

check_configuration()
{
    if [[ $network != 'mainnet' && $network != 'devnet' ]]; then
        abort 1 "network [$network] is invalid."
    fi
}
