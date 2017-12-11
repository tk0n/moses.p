#!/usr/bin/env bash

# ---------------------------------------------------------------------------
# This file is part of ARK Moses.
#
# (c) Brian Faust <hello@brianfaust.me>
#
# For the full copyright and license information, please view the LICENSE
# file that was distributed with this source code.
# ---------------------------------------------------------------------------

moses_uninstall()
{
    heading "Starting Uninstallation..."
    rm -rf $moses_dir
    success "Uninstallation complete!"

    exit 1
}
