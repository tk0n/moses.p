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
# ARK
# -------------------------

ark_dir=$(locate -b '\ark-node')

# -------------------------
# Network
# -------------------------

network=$(cd $ark_dir && git symbolic-ref --short -q HEAD)
