#!/usr/bin/env bash

# ---------------------------------------------------------------------------
# This file is part of ARK Moses.
#
# (c) Brian Faust <hello@brianfaust.me>
#
# For the full copyright and license information, please view the LICENSE
# file that was distributed with this source code.
# ---------------------------------------------------------------------------

# -------------------------
# Required Variables
# -------------------------

moses=$(basename "$0")
moses_dir="${HOME}/ARK-Moses"
moses_log="${moses_dir}/moses.log"
. "$moses_dir/variables.sh"

# -------------------------
# Modules
# -------------------------

. "$moses_dir/modules/colours.sh"
. "$moses_dir/modules/errors.sh"
. "$moses_dir/modules/bootstrap.sh"
. "$moses_dir/modules/config.sh"
. "$moses_dir/modules/dump.sh"
. "$moses_dir/modules/commands.sh"
. "$moses_dir/modules/install.sh"
. "$moses_dir/modules/args.sh"

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
