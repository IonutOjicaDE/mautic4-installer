#!/bin/bash
current_dir=$(dirname "$(readlink -f "$0")")
source "${current_dir}/mautic.sh"
NOW=$(TZ="Europe/Berlin" date +"%Y-%m-%d-%H-%M")

cd "${BACKUP_FILES_FOLDER}"
# Fac copie de rezervă a bazei de date Mautic
mysqldump -u root -p${MYSQL_ROOT_PASSWORD} --single-transaction --quick --lock-tables=false --no-tablespaces "mautic${MAUTIC_COUNT}" > "mautic-database-${NOW}.sql"
zip "mautic-database-${NOW}.zip" "mautic-database-${NOW}.sql" > /dev/null
rm "mautic-database-${NOW}.sql"

# Şterg cache-ul
rm -rf "${MAUTIC_FOLDER}var/cache/*"
rm -rf "${MAUTIC_FOLDER}var/tmp/*"
# Fac copie de rezervă a fişierelor Mautic
zip -rq "mautic-files-${NOW}.zip" "${MAUTIC_FOLDER}"

# Refac permisiunile dosarului Mautic
#chown -R www-data:www-data "${MAUTIC_FOLDER}"
#chmod -R 755 "${MAUTIC_FOLDER}"
#. $dosar_fisiere_root'reset-mautic-permissions.sh'

# Reîmprospătez cache-ul
# Suprim output-ul (iesirea) comenzii, redirectionand iesirea standard (stdout) catre null: > /dev/null
# Redirectionez si iesirea de eroare (stderr) catre null: 2>&1
php "${MAUTIC_FOLDER}bin/console cache:warmup" --no-interaction > /dev/null 2>&1

# Şterg copiile de rezervă mai vechi de 8 zile
find "${BACKUP_FILES_FOLDER}*" -mtime +8 -exec rm {} \;

# Copiile de rezervă "${BACKUP_FILES_FOLDER}"mautic-database-${NOW}.zip şi mautic-files-${NOW}.zip sunt create

# Şterg jurnalele mai vechi de 30 zile
find "${CRON_FOLDER}log/*" -mtime +30 -exec rm {} \;
