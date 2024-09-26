#!/bin/bash
current_dir=$(dirname "$(readlink -f "$0")")
source "${current_dir}/mautic.sh"
NOW=$(TZ="Europe/Berlin" date +"%Y-%m-%d-%H-%M")

cd "${BACKUP_FILES_FOLDER}"
# Backup copy of Mautic database
mysqldump -u root -p${MYSQL_ROOT_PASSWORD} --single-transaction --quick --lock-tables=false --no-tablespaces "mautic${MAUTIC_COUNT}" > "mautic-database-${NOW}.sql"
zip "mautic-database-${NOW}.zip" "mautic-database-${NOW}.sql" > /dev/null
rm "mautic-database-${NOW}.sql"

# Delete cache files
rm -rf "${MAUTIC_FOLDER}var/cache/*"
rm -rf "${MAUTIC_FOLDER}var/tmp/*"
# Backup copy of Mautic files
zip -rq "mautic-files-${NOW}.zip" "${MAUTIC_FOLDER}"

# Assign permissions for Mautic folder
#chown -R www-data:www-data "${MAUTIC_FOLDER}"
#chmod -R 755 "${MAUTIC_FOLDER}"
#. $dosar_fisiere_root'reset-mautic-permissions.sh'

# Recreate cache
# Silence output, redirecting standard output (stdout) to null: > /dev/null
# Redirecting also error output (stderr) to null: 2>&1
php "${MAUTIC_FOLDER}bin/console cache:warmup" --no-interaction > /dev/null 2>&1

# Delete backup copies older than 8 days
find "${BACKUP_FILES_FOLDER}*" -mtime +8 -exec rm {} \;

# Following backup files are created: "${BACKUP_FILES_FOLDER}"mautic-database-${NOW}.zip and mautic-files-${NOW}.zip

# Delete also logs older than 30 days
find "${CRON_FOLDER}log/*" -mtime +30 -exec rm {} \;
