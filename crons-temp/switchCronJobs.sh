#!/bin/bash
. $(dirname "$(readlink -f "$0")")'/mautic.sh'
if [ -e "${MAUTIC_FOLDER}DO-NOT-RUN" ]; then
  mv "${MAUTIC_FOLDER}DO-NOT-RUN" "${MAUTIC_FOLDER}DO--RUN"
elif [ -e "/var/mautic-crons/DO--RUN" ]; then
  mv "${MAUTIC_FOLDER}DO--RUN" "${MAUTIC_FOLDER}DO-NOT-RUN"
else
  touch "${MAUTIC_FOLDER}DO-NOT-RUN"
fi
