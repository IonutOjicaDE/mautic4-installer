#!/bin/bash

show_info 🛈 'Sending passwords over email...'

DEBIAN_FRONTEND=noninteractive apt-get -yq install sendemail

email_subject="Password created for $MAUTIC_SUBDOMAIN $(date +'%Y-%m-%d %H:%M')"
email_content=$(cat <<EOL
Hello $SENDER_FIRSTNAME,

Mautic is installed and is already running ! $(if [[ "${SSL_CERTIFICATE,,}" == "test" ]]; then echo "The SSL certificate was installed only as a test!"; fi)$(if [[ "${SSL_CERTIFICATE,,}" != "test" && "${SSL_CERTIFICATE,,}" != "yes" ]]; then echo "No SSL certificate was installed!"; fi)

You can login to Mautic here: https://$MAUTIC_SUBDOMAIN

use username: ${MAUTIC_USERNAME}
and password: ${MAUTIC_ADMIN_PASSWORD}

Attached you can find the file with all the passwords created during installation.

PS: to use the utility commands.php, use the following link:
https://$MAUTIC_SUBDOMAIN/commands.php
and the password: ${MAUTIC_COMMANDS_PASSWORD}

Have a great day!
The automated install script for Mautic created by
Ionut Ojica

EOL
)

if check_positive "${SEND_PASS_TO_SENDER_EMAIL}"; then
  show_info 🛈 "Paswords will be sent also to $SENDER_EMAIL ."
  sendemail -f $FROM_EMAIL -s $FROM_SERVER_PORT -xu $FROM_USER -xp ''$FROM_PASS'' -t $SENDER_EMAIL -cc $ADMIN_EMAIL -m "$email_content" -a $CRON_FOLDER'mautic.txt' -u "$email_subject" -o message-charset=utf-8
else
  show_info 🛈 "Paswords will NOT be sent to $SENDER_EMAIL ."
  sendemail -f $FROM_EMAIL -s $FROM_SERVER_PORT -xu $FROM_USER -xp ''$FROM_PASS'' -t $ADMIN_EMAIL -m "$email_content" -a $CRON_FOLDER'mautic.txt' -u "$email_subject" -o message-charset=utf-8
fi

show_info ✅ "Email sent."
