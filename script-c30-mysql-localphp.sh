#!/bin/bash

###############################################################################
#                                                                             #
# Configure MySQL, local.php, copy commands.php, ro-translation               #
#                                                                             #
###############################################################################

show_info 🛈 'Downloading MySQL database template...'
wget -q "${URL_TO_FILES}mautic-database-template-ro.zip"
unzip mautic-database-template-ro.zip
rm mautic-database-template-ro.zip

sed -i "s|###SENDER_EMAIL###|$SENDER_EMAIL|g" mautic-database-template-ro.sql
sed -i "s|###MAUTIC_USERNAME###|$MAUTIC_USERNAME|g" mautic-database-template-ro.sql
sed -i "s|###MAIN_DOMAIN###|$MAIN_DOMAIN|g" mautic-database-template-ro.sql
sed -i "s|###MAUTIC_SUBDOMAIN###|$MAUTIC_SUBDOMAIN|g" mautic-database-template-ro.sql
sed -i "s|###SENDER_FIRSTNAME###|$SENDER_FIRSTNAME|g" mautic-database-template-ro.sql
sed -i "s|###SENDER_LASTNAME###|$SENDER_LASTNAME|g" mautic-database-template-ro.sql

mysql -u root -p${MYSQL_ROOT_PASSWORD} mautic${MAUTIC_COUNT} < mautic-database-template-ro.sql
rm mautic-database-template-ro.sql

show_info ✅ 'MySQL database installed.'


show_info 🛈 'Save encrypted password for mautic admin in the database...'
mautic_admin_password_md5=$(echo "$MAUTIC_ADMIN_PASSWORD" | openssl passwd -1 -stdin)
echo "use mautic${MAUTIC_COUNT}; UPDATE users SET password='${mautic_admin_password_md5}' WHERE username='${MAUTIC_USERNAME}';" | mysql -u root -p${MYSQL_ROOT_PASSWORD}

if [ -z "$MAUTIC_COUNT" ]; then
  show_info 🛈 'Change authentification to MySQL of root user from localhost to mysql_native_password...'
  #Schimbă parola utilizatorului root
  echo "ALTER USER 'root'@'localhost' IDENTIFIED VIA 'mysql_native_password';ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';FLUSH PRIVILEGES;" | mysql -u root
else
  show_info 🛈 'NO change of the authentification to MySQL of root user from localhost to mysql_native_password...'
fi


show_info 🛈 'Downloading local.php...'
LOCAL_PHP_FILE='local.ro.php'
wget -q "${URL_TO_FILES}${LOCAL_PHP_FILE}"

show_info 🛈 'Personalize local.php...'
sed -i "s|###SENDER_EMAIL###|$SENDER_EMAIL|g" "${LOCAL_PHP_FILE}"
sed -i "s|###MAIN_DOMAIN###|$MAIN_DOMAIN|g" "${LOCAL_PHP_FILE}"
sed -i "s|###MAUTIC_SUBDOMAIN###|$MAUTIC_SUBDOMAIN|g" "${LOCAL_PHP_FILE}"
sed -i "s|###SENDER_FIRSTNAME###|$SENDER_FIRSTNAME|g" "${LOCAL_PHP_FILE}"
sed -i "s|###SENDER_LASTNAME###|$SENDER_LASTNAME|g" "${LOCAL_PHP_FILE}"
sed -i "s|###MAUTIC_FOLDER###|$MAUTIC_FOLDER|g" "${LOCAL_PHP_FILE}"
sed -i "s|###MAUTIC_SECRET_KEY###|$MAUTIC_SECRET_KEY|g" "${LOCAL_PHP_FILE}"
sed -i "s|###MAUTIC_REMEMBERME_KEY###|$MAUTIC_REMEMBERME_KEY|g" "${LOCAL_PHP_FILE}"

sed -i "s|###mysql_mautic_database###|mautic${MAUTIC_COUNT}|g" "${LOCAL_PHP_FILE}"
sed -i "s|###mysql_mauticuser_name###|mauticuser${MAUTIC_COUNT}|g" "${LOCAL_PHP_FILE}"
sed -i "s|###MYSQL_MAUTICUSER_PASSWORD###|$MYSQL_MAUTICUSER_PASSWORD|g" "${LOCAL_PHP_FILE}"
sed -i "s|###SENDER_TIMEZONE###|$SENDER_TIMEZONE|g" "${LOCAL_PHP_FILE}"

mv "${LOCAL_PHP_FILE}" "${MAUTIC_FOLDER}app/config/local.php"
show_info ✅ 'local.php installed.'


show_info 🛈 'Install romanian laguage package'
#wget 'https://updates.mautic.org/index.php?option=com_mauticdownload&task=downloadLanguagePackage&langCode=ro_RO' -O ro_RO.zip
wget "${URL_TO_FILES}ro_RO.zip"
unzip -q -o ro_RO.zip -d "${MAUTIC_FOLDER}translations/"
rm ro_RO.zip
show_info ✅ 'Romanian laguage package installed.'

chown -R www-data:www-data "${MAUTIC_FOLDER}"
chmod -R 755 "${MAUTIC_FOLDER}"
