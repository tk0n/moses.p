#!/usr/bin/env bash

moses_schedule()
{
    while true; do
        moses_dump

        if (( $snapshot_interval > 0 )); then
            sleep $snapshot_interval
        fi
    done
}
