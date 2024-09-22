#!/bin/bash

###############################################################################
#                                                                             #
# Creating passwords and saving the file                                      #
#                                                                             #
###############################################################################

show_info 🛈 'Creating passwords and saving the file...'

if [ -z "${MYSQL_ROOT_PASSWORD}" ]; then
      MYSQL_ROOT_PASSWORD=$(cat /dev/urandom | tr -dc '1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_' | head -c40)
fi
if [ -z "${ROOT_USER_PASSWORD}" ]; then
       ROOT_USER_PASSWORD=$(cat /dev/urandom | tr -dc '1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_' | head -c40)
fi
MYSQL_MAUTICUSER_PASSWORD=$(cat /dev/urandom | tr -dc '1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_' | head -c40)
        MAUTIC_SECRET_KEY=$(cat /dev/urandom | tr -dc '1234567890abcdef' | head -c64)
    MAUTIC_REMEMBERME_KEY=$(cat /dev/urandom | tr -dc '1234567890abcdefghijklmnopqrstuvwxyz' | head -c40)
    MAUTIC_ADMIN_PASSWORD=$(cat /dev/urandom | tr -dc '1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_' | head -c40)

 MAUTIC_COMMANDS_PASSWORD=$(cat /dev/urandom | tr -dc '1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_' | head -c40)
              MAIN_DOMAIN=$(echo "$MAUTIC_SUBDOMAIN" | cut -d'.' -f2-)
          MAUTIC_USERNAME=$(echo "$MAUTIC_SUBDOMAIN" | sed 's/\.//g')

            MAUTIC_FOLDER="/var/www/mautic${MAUTIC_COUNT}/"
              CRON_FOLDER="/var/mautic${MAUTIC_COUNT}-crons/"
      BACKUP_FILES_FOLDER="/var/mautic${MAUTIC_COUNT}-backups/"
        ROOT_FILES_FOLDER="/usr/local/bin/"

show_info ✅ 'Passwords created. Saving the passwords in .sh, .php, .txt files...'

mkdir "${CRON_FOLDER}"

content_file_sh="
MAIN_DOMAIN='${MAIN_DOMAIN}'
MAUTIC_SUBDOMAIN='${MAUTIC_SUBDOMAIN}'
SENDER_EMAIL='${SENDER_EMAIL}'
SENDER_FIRSTNAME='${SENDER_FIRSTNAME}'
SENDER_LASTNAME='${SENDER_LASTNAME}'

MAUTIC_FOLDER='${MAUTIC_FOLDER}'
CRON_FOLDER='${CRON_FOLDER}'
BACKUP_FILES_FOLDER='${BACKUP_FILES_FOLDER}'
ROOT_FILES_FOLDER='${ROOT_FILES_FOLDER}'

MAUTIC_COUNT='${MAUTIC_COUNT}'
MYSQL_ROOT_PASSWORD='${MYSQL_ROOT_PASSWORD}'
MYSQL_MAUTICUSER_PASSWORD='${MYSQL_MAUTICUSER_PASSWORD}'

MAUTIC_SECRET_KEY='${MAUTIC_SECRET_KEY}'
MAUTIC_REMEMBERME_KEY='${MAUTIC_REMEMBERME_KEY}'

MAUTIC_USERNAME='${MAUTIC_USERNAME}'
MAUTIC_ADMIN_PASSWORD='${MAUTIC_ADMIN_PASSWORD}'

ROOT_USER_PASSWORD='${ROOT_USER_PASSWORD}'

MAUTIC_COMMANDS_PASSWORD='${MAUTIC_COMMANDS_PASSWORD}'

$ADMIN_EMAIL='${ADMIN_EMAIL}'

FROM_EMAIL='${FROM_EMAIL}'
FROM_SERVER_PORT='${FROM_SERVER_PORT}'
FROM_USER='${FROM_USER}'
FROM_PASS='${FROM_PASS}'
"
printf "#!/bin/bash\n%s\n" "${content_file_sh}" > "${CRON_FOLDER}mautic.sh"
show_info ✅ 'Passwords saved in .sh file.'

content_file_php=""
while IFS= read -r current_line; do
  if [[ "${current_line}" == *=* ]]; then
    temp="${current_line%=*}"
    content_file_php+="$""$temp='${!temp}';"$'\n'
  else
    content_file_php+="${current_line}"$'\n'
  fi
done <<< "${content_file_sh}"
show_info ✅ 'Passwords saved in .php file.'

printf "<?php\n%s\n?>" "${content_file_php}" > "${CRON_FOLDER}mautic.php"

content_file_txt=""
while IFS= read -r current_line; do
  if [[ "${current_line}" == *=* ]]; then
    content_file_txt+=$(echo "${current_line}" | sed "s/=/ = /g; s/'//g")$'\n'
  else
    content_file_txt+="${current_line}"$'\n'
  fi
done <<< "${content_file_sh}"

printf "${content_file_txt}" > "${CRON_FOLDER}mautic.txt"
show_info ✅ 'Passwords saved in .txt file.'
