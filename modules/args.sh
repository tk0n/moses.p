#!/usr/bin/env bash

# ---------------------------------------------------------------------------
# This file is part of ARK Snapshooter.
#
# (c) Brian Faust <hello@brianfaust.me>
#
# For the full copyright and license information, please view the LICENSE
# file that was distributed with this source code.
# ---------------------------------------------------------------------------

parse_args()
{
    case "$1" in
        dump)
            snapshooter_dump
        ;;
        install)
            snapshooter_install
        ;;
        uninstall)
            snapshooter_uninstall
        ;;
        update)
            snapshooter_update
        ;;
        config)
            snapshooter_config
        ;;
        log)
            snapshooter_tail
        ;;
        version)
            snapshooter_version
            exit 1
        ;;
        help|*)
            snapshooter_help
            exit 1
        ;;
    esac
}
