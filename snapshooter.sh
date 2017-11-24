#!/usr/bin/env bash

# Step 1: Declare Variables

ark_dir=$(locate -b '\ark-node')
network=$(cd $ark_dir && git symbolic-ref --short -q HEAD)
snapshot_dir=~/snapshots

# Step 2: Create New Snapshot

cd $snapshot_dir
pg_dump -Fc ark_${network} > latest

# Step 3: Remove Old Snapshot

rm -f current
mv latest current
