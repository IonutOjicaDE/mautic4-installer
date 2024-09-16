#!/bin/bash

. '###CRON_FOLDER###mautic.sh'

chown -R www-data:www-data ${CRON_FOLDER}
chmod -R 755 ${CRON_FOLDER}
chown -R www-data:www-data ${BACKUP_FILES_FOLDER}
chmod -R 755 ${BACKUP_FILES_FOLDER}
chown -R www-data:www-data ${MAUTIC_FOLDER}
chmod -R 755 ${MAUTIC_FOLDER}

echo "$(date +%H:%M:%S) Permissions for ${MAUTIC_FOLDER} successfully reseted."
