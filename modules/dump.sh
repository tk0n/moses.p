#!/usr/bin/env bash

# ---------------------------------------------------------------------------
# This file is part of moses.
#
# (c) Brian Faust <hello@brianfaust.me>
#
# For the full copyright and license information, please view the LICENSE
# file that was distributed with this source code.
# ---------------------------------------------------------------------------

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

    # check if we send the snapshot to a remote location
    if [[ $snapshot_remote = true ]]; then
        rsync --checksum --no-whole-file -v -e "ssh -p ${snapshot_remote_port} -i ${snapshot_remote_identity_file}" current "${snapshot_remote_user}@${snapshot_remote_host}:${snapshot_remote_directory}"
    fi
}
