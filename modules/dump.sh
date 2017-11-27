#!/usr/bin/env bash

snapshooter_dump()
{
    cd $snapshot_dir
    pg_dump -Fc ark_${network} > latest

    rm -f current
    mv latest current
}
