#!/usr/bin/env bash

# ---------------------------------------------------------------------------
# This file is part of ARK Moses.
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
