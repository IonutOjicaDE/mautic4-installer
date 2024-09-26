#!/bin/bash
. $(dirname "$(readlink -f "$0")")'/mautic.sh'
if [ -e "${CRON_FOLDER}DO-NOT-RUN" ]; then
  mv "${CRON_FOLDER}DO-NOT-RUN" "${CRON_FOLDER}DO--RUN"
elif [ -e "/var/mautic-crons/DO--RUN" ]; then
  mv "${CRON_FOLDER}DO--RUN" "${CRON_FOLDER}DO-NOT-RUN"
else
  touch "${CRON_FOLDER}DO-NOT-RUN"
fi
