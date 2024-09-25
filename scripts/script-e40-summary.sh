#!/bin/bash

###############################################################################################
#####                                   Display summary                                   #####
###############################################################################################

echo
echo
echo
echo '==========================================================================================================================='
echo
echo "Mautic installation is finished!"
if [ "${SSL_CERTIFICATE,,}" == "test" ]; then
  echo 'SSL certificate was installed only for test!'
  echo
elif [ "${SSL_CERTIFICATE,,}" == "yes" ]; then
  echo 'A production ready SSL certificate was installed.'
  echo
else
  echo 'No SSL certificate was installed.'
  echo
fi
echo
echo "You can login to Mautic here: https://${MAUTIC_SUBDOMAIN}"
echo "use username: ${MAUTIC_USERNAME}"
echo "and password: ${MAUTIC_ADMIN_PASSWORD}"
echo
echo "Passwords created during installations were sent to $(check_positive "${SEND_PASS_TO_SENDER_EMAIL}" && echo "${SENDER_EMAIL} and to ")${ADMIN_EMAIL}"
echo
echo '==========================================================================================================================='
echo 'Updated for Mautic 4 by Ionuţ Ojică - contact@ionutojica.com'
echo
echo 'Source created by Matthias Reich - Info@Online-Business-Duplicator.de ( https://online-business-duplicator.de/mautic ).'
echo
echo '==========================================================================================================================='
