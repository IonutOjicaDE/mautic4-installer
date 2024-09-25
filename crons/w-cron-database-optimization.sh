#!/bin/bash
current_dir=$(dirname "$(readlink -f "$0")")

exec 100>"${current_dir}/cron.lock" || exit 1
flock -w 60 100 || exit 1

source "${current_dir}/cron-database-optimization.sh" > /dev/null 2>&1
