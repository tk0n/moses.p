#!/usr/bin/env bash

# ---------------------------------------------------------------------------
# This file is part of moses.
#
# (c) Brian Faust <hello@brianfaust.me>
#
# For the full copyright and license information, please view the LICENSE
# file that was distributed with this source code.
# ---------------------------------------------------------------------------

parse_args()
{
    case "$1" in
        start)
            moses_start
        ;;
        stop)
            moses_stop
        ;;
        restart)
            moses_restart
        ;;
        reload)
            moses_reload
        ;;
        delete)
            moses_delete
        ;;
        schedule)
            moses_schedule
        ;;
        dump)
            moses_dump
        ;;
        install)
            moses_install
        ;;
        uninstall)
            moses_uninstall
        ;;
        update)
            moses_update
        ;;
        config)
            moses_config
        ;;
        log)
            moses_tail
        ;;
        alias)
            moses_alias
        ;;
        version)
            moses_version
            exit 1
        ;;
        help|*)
            moses_help
            exit 1
        ;;
    esac
}
