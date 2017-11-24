#!/usr/bin/env bash

# Step 1: Declare Variables

ark_dir=$(locate -b '\ark-node')
network=$(cd $ark_dir && git symbolic-ref --short -q HEAD)
snapshooter_dir=$(locate -b '\ARK-Snapshooter')

# Step 2: Create New Snapshot

cd $snapshooter_dir
pg_dump -Fc ark_{$network} > latest

# Step 3: Remove Old Snapshot

rm -f current
ls -ltr | awk '{ field = $NF }; END{ print field }' | xargs -I '{}' mv '{}' current
