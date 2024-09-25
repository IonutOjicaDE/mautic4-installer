#!/bin/bash

###############################################################################################
#####                                 Install Adminer                                     #####
###############################################################################################

show_info ${ICON_INFO} 'Download Adminer...'

#wget "${URL_TO_FILES}bazadate.zip"
#unzip -q bazadate.zip -d "${MAUTIC_FOLDER}"
#rm bazadate.zip

mkdir -p "${MAUTIC_FOLDER}database/plugins"

cd "${MAUTIC_FOLDER}database/"
wget -q "${ADMINER_DOWNLOAD_URL}"
mv "${INSTALL_FOLDER}other/database.php" "${MAUTIC_FOLDER}database/"

cd "${MAUTIC_FOLDER}database/plugins/"
wget -q https://raw.githubusercontent.com/adminerevo/adminerevo/master/plugins/plugin.php
wget -q https://raw.githubusercontent.com/adminerevo/adminerevo/master/plugins/edit-textarea.php
wget -q https://raw.githubusercontent.com/adminerevo/adminerevo/master/plugins/file-upload.php
wget -q https://raw.githubusercontent.com/adminerevo/adminerevo/master/plugins/foreign-system.php
wget -q https://raw.githubusercontent.com/adminerevo/adminerevo/master/plugins/tables-filter.php
wget -q https://raw.githubusercontent.com/adminerevo/adminerevo/master/plugins/tinymce.php

chown -R www-data:www-data "${MAUTIC_FOLDER}"
chmod -R 755 "${MAUTIC_FOLDER}"

cd "${PWD}"

show_info ${ICON_OK} 'Adminer is installed.'
