#!/bin/bash
#https://www.putorius.net/lock-files-bash-scripts.html
current_dir=$(dirname "$(readlink -f "$0")")

exec 100>"${current_dir}/cron.lock" || exit 1
flock -w 60 100 || exit 1

php ${current_dir}/cron-maintenance-cleanup.php > /dev/null 2>&1
