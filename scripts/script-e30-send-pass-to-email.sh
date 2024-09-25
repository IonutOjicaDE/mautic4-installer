#!/bin/bash

###############################################################################################
#####                            Sending passwords over email                             #####
###############################################################################################

DEBIAN_FRONTEND=noninteractive apt-get -yq install sendemail

email_subject="Passwords created for ${MAUTIC_SUBDOMAIN} $(date +'%Y-%m-%d %H:%M')"
email_content=$(cat <<EOL
Hello ${SENDER_FIRSTNAME},

Mautic is installed and is already running ! $(if [[ "${SSL_CERTIFICATE,,}" == "test" ]]; then echo "The SSL certificate was installed only as a test!"; fi)$(if [[ "${SSL_CERTIFICATE,,}" != "test" && "${SSL_CERTIFICATE,,}" != "yes" ]]; then echo "No SSL certificate was installed!"; fi)

You can login to Mautic here: https://$MAUTIC_SUBDOMAIN

use username: ${MAUTIC_USERNAME}
and password: ${MAUTIC_ADMIN_PASSWORD}

Attached you can find the file with all the passwords created during installation.

PS: to use the utility commands.php, use the following link:
https://${MAUTIC_SUBDOMAIN}/commands/commands.php
and the password: ${MAUTIC_COMMANDS_PASSWORD}

Have a great day!
The automated install script for Mautic created by
Ionut Ojica

EOL
)

if check_positive "${SEND_PASS_TO_SENDER_EMAIL}"; then
  sendemail -f "${FROM_EMAIL}" -s "${FROM_SERVER_PORT}" -xu "${FROM_USER}" -xp ''${FROM_PASS}'' -t "${SENDER_EMAIL}" -cc "${ADMIN_EMAIL}" -m "${email_content}" -a "$CRON_FOLDER}mautic.txt" -u "${email_subject}" -o message-charset=utf-8
else
  sendemail -f "${FROM_EMAIL}" -s "${FROM_SERVER_PORT}" -xu "${FROM_USER}" -xp ''${FROM_PASS}'' -t "${ADMIN_EMAIL}" -m "${email_content}" -a "${CRON_FOLDER}mautic.txt" -u "${email_subject}" -o message-charset=utf-8
fi

show_info ${ICON_OK} "Email '${email_subject}' sent to $(check_positive "${SEND_PASS_TO_SENDER_EMAIL}" && echo "${SENDER_EMAIL} and to ")${ADMIN_EMAIL}."
