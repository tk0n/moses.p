#!/usr/bin/env bash

# ---------------------------------------------------------------------------
# This file is part of moses.
#
# (c) Brian Faust <hello@brianfaust.me>
#
# For the full copyright and license information, please view the LICENSE
# file that was distributed with this source code.
# ---------------------------------------------------------------------------

# -------------------------
# Persona
# -------------------------

persona_dir=$(locate -b '\persona-mainnet')

# -------------------------
# Network
# -------------------------

network=$(cd $persona_dir && git symbolic-ref --short -q HEAD | sed 's/[^-]*-//')
