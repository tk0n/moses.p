#!/usr/bin/env bash

# ---------------------------------------------------------------------------
# This file is part of ARK Snapshooter.
#
# (c) Brian Faust <hello@brianfaust.me>
#
# For the full copyright and license information, please view the LICENSE
# file that was distributed with this source code.
# ---------------------------------------------------------------------------

# -------------------------
# Required Variables
# -------------------------

snapshooter=$(basename "$0")
snapshooter_dir=$(dirname "$0")
snapshooter_log="${snapshooter_dir}/snapshooter.log"

# -------------------------
# Modules
# -------------------------

. "$snapshooter_dir/modules/colours.sh"
. "$snapshooter_dir/modules/errors.sh"
. "$snapshooter_dir/modules/bootstrap.sh"
. "$snapshooter_dir/modules/config.sh"
. "$snapshooter_dir/modules/dump.sh"
. "$snapshooter_dir/modules/commands.sh"
. "$snapshooter_dir/modules/install.sh"
. "$snapshooter_dir/modules/args.sh"

# -------------------------
# Start
# -------------------------

function main()
{
    setup_environment
    check_configuration

    parse_args "$@"

    trap cleanup SIGINT SIGTERM SIGKILL
}

main "$@"
