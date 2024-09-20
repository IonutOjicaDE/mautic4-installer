#!/bin/bash

###############################################################################
#                                                                             #
# Configure Cronjobs                                                          #
#                                                                             #
###############################################################################

show_info 🛈 'Configure Cronjobs: mautic-crons.zip , crontab'

show_info 🛈 'Downloading cron scripts...'
mkdir "${BACKUP_FILES_FOLDER}"

wget -q "${URL_TO_FILES}mautic-crons.zip"
unzip -q mautic-crons.zip -d "${CRON_FOLDER}"
rm mautic-crons.zip

chown -R www-data:www-data "${CRON_FOLDER}"
chown -R www-data:www-data "${BACKUP_FILES_FOLDER}"
chmod -R 755 "${CRON_FOLDER}"
chmod -R 755 "${BACKUP_FILES_FOLDER}"
show_info ✅ 'Cron scripts installed.'


if [ ! -z "${MAUTIC_COUNT}" ] || [ "${MAUTIC_COUNT}" -eq 1 ]; then
  echo "" > crontab_temp
  cron_execution_hour="1"
else
  crontab -u www-data -l > crontab_temp
  cron_execution_hour="${MAUTIC_COUNT}"
fi
file_content="$(cat << EOF
1 ${cron_execution_hour} * * * bash ${CRON_FOLDER}w-cron-iplookup-download.sh >> ${CRON_FOLDER}w-cron.log 2>&1
10 ${cron_execution_hour} * * * bash ${CRON_FOLDER}w-cron-backup.sh >> ${CRON_FOLDER}w-cron.log 2>&1
20 ${cron_execution_hour} * * * bash ${CRON_FOLDER}w-cron-duplicate.sh >> ${CRON_FOLDER}w-cron.log 2>&1
25 ${cron_execution_hour} * * * bash ${CRON_FOLDER}w-cron-database-optimization.sh >> ${CRON_FOLDER}w-cron.log 2>&1
30 ${cron_execution_hour} ${cron_execution_hour} * * bash ${CRON_FOLDER}w-cron-maintenance-cleanup.sh >> ${CRON_FOLDER}w-cron.log 2>&1
* * * * * bash ${CRON_FOLDER}w-cron-all.sh >> ${CRON_FOLDER}w-cron.log 2>&1
2${cron_execution_hour} * * * * bash ${CRON_FOLDER}send-email.sh >> ${CRON_FOLDER}w-cron.log 2>&1
EOF
)"
echo "${file_content}" >> crontab_temp
crontab -u www-data crontab_temp
rm crontab_temp
show_info ✅ 'Crons for web user installed.'


sed -i "s|###CRON_FOLDER###|${CRON_FOLDER}|g" reset-mautic-permissions.sh
mv reset-mautic-permissions.sh "${ROOT_FILES_FOLDER}reset-mautic${MAUTIC_COUNT}-permissions.sh"
chmod a+x "${ROOT_FILES_FOLDER}reset-mautic${MAUTIC_COUNT}-permissions.sh"
show_info ✅ 'Cron script for root user installed.'


if [ ! -z "${MAUTIC_COUNT}" ] || [ "${MAUTIC_COUNT}" -eq 1 ]; then
  echo "" > crontab_temp
else
  crontab -l > crontab_temp
fi
file_content="$(cat << EOF
4${cron_execution_hour} 0 * * * bash ${ROOT_FILES_FOLDER}reset-mautic${MAUTIC_COUNT}-permissions.sh >> ${CRON_FOLDER}r-cron.log 2>&1
EOF
)"
echo "${file_content}" >> crontab_temp
crontab crontab_temp
rm crontab_temp
show_info ✅ 'Crons for root user installed.'

show_info 🛈 'Clearing cache...'
php "${CRON_FOLDER}cron-clear-cache.php"

chown -R www-data:www-data "${MAUTIC_FOLDER}"
chmod -R 755 "${MAUTIC_FOLDER}"

show_info ✅ 'Crons are installed.'
