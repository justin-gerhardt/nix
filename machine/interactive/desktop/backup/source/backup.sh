#! /usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail
@sanoid@ --verbose --debug --cron --configdir @configFolder@
@syncoid@ --compress none --sendoptions="--raw" --sshkey=@sshkey@ zroot/encrypted/home justin@192.168.0.200:mediaPool/backup/desktop-home
