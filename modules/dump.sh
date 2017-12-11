#!/usr/bin/env bash

moses_dump()
{
    # make sure postgres is running
    process_postgres=$(pgrep -a postgres | awk '{print $1}')

    if [ -z "$process_postgres" ]; then
        sudo service postgresql start
    fi

    # go into the snapshot dir
    cd $snapshot_dir

    # create a new snapshot
    pg_dump -Fc ark_${network} > latest

    # move old snapshot
    current_file=current # $(ls -t | head -n1)
    current_date=$(stat -c %Y $current_file)
    mv $current_file $current_date

    # move new snapshot
    mv latest $current_file

    # delete all but the 10 recent snapshots
    ls -t | tail -n +$snapshot_amount | xargs rm --
}
