#!/bin/bash
run() {
    echo "Next command to be executed: $1"
    read -p "Press ENTER to continue..."
    eval $1
}

#set -x
. '/var/mautic-crons/mautic.sh'

run "chown -R www-data:www-data ${MAUTIC_FOLDER}"
run "chmod -R 755 ${MAUTIC_FOLDER}"
#1. Try to clear cache
run "php ${MAUTIC_FOLDER}bin/console cache:clear"

#2. Trigger update manually
run "php ${MAUTIC_FOLDER}bin/console mautic:update:find"
run "php ${MAUTIC_FOLDER}bin/console mautic:update:apply"
run "php ${MAUTIC_FOLDER}bin/console mautic:update:apply --finish"

#3. Try to run database migrations
run "php ${MAUTIC_FOLDER}bin/console doctrine:migration:status"
run "php ${MAUTIC_FOLDER}bin/console doctrine:migration:migrate"

#4. Try to update database schema
run "php ${MAUTIC_FOLDER}bin/console doctrine:schema:update --dump-sql"
#=> urmatoarea nu trebuie rulata ! vezi aici: https://github.com/mautic/mautic/issues/11204#issuecomment-1161441244
#/usr/bin/php /var/www/html/m/bin/console doctrine:schema:update --force

#5. Vergib Schreibberechtigungen für das Mautic-Installationsverzeichnis
run "chown -R www-data:www-data ${MAUTIC_FOLDER}"
run "chmod -R 755 ${MAUTIC_FOLDER}"

#6. Revert changes to system files
run "perl -s script-d10-adjusting.perl \"${MAUTIC_FOLDER}\" \"${MAUTIC_SUBDOMAIN}\""
#perl -s script-ajustari.perl "/var/www/mautic/" "test.ionutojica.com"

#7. Try to clear cache
run "php ${MAUTIC_FOLDER}bin/console cache:clear"

#set +x
