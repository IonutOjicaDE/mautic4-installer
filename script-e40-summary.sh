#!/bin/bash

show_info 🛈 'Display summary...'


echo
echo
echo
echo '==========================================================================================================================='
echo
echo "Mautic installation is finished!${SSL_CERTIFICATE:+ SSL certificate was installed only for test!}"
echo
echo "You can login to Mautic here: https://${MAUTIC_SUBDOMAIN}"
echo "use username: ${MAUTIC_USERNAME}"
echo "and password: ${MAUTIC_ADMIN_PASSWORD}"
echo
echo "Passwords created during installations were sent to: ${SEND_PASS_TO_SENDER_EMAIL:+$SENDER_EMAIL and to }$ADMIN_EMAIL"
echo
echo '==========================================================================================================================='
echo 'Updated for Mautic 4 by Ionuţ Ojică - contact@ionutojica.com'
echo
echo 'Source created by Matthias Reich - Info@Online-Business-Duplicator.de ( https://online-business-duplicator.de/mautic ).'
echo
echo '==========================================================================================================================='
