#!/bin/bash

###############################################################################################
#####                              Install Theme and icons                                #####
###############################################################################################


show_info ${ICON_INFO} 'Installing Dashboard...'
DASHBOARD_FILE="${INSTALL_FOLDER}other/dashboard-20231009.json"
if [[ ! -e "${DASHBOARD_FILE}" ]]; then
  show_info ${ICON_ERR} "Dashboard template does not exists and should be in the downloaded archive..."
  show_info ${ICON_ERR} "Missing dashboard template: ${DASHBOARD_FILE} !"
  show_info ${ICON_ERR} "Should the installation continue?"
  answer_yes_else_stop && continue
fi
mv "${DASHBOARD_FILE}" "${MAUTIC_FOLDER}media/dashboards/"
show_info ${ICON_OK} 'Dashboard installed.'


show_info ${ICON_INFO} 'Installing theme 460c-Simplu...'
wget -q 'https://github.com/IonutOjicaDE/mautic-theme-simple-460/archive/refs/heads/main.zip' -O 460c-Simplu.zip
unzip -q 460c-Simplu.zip
mv "mautic-theme-simple-460/src" "${MAUTIC_FOLDER}themes/460c-Simplu"
rm mautic-theme-simple-460
rm 460c-Simplu.zip
show_info ${ICON_OK} 'Theme 460c-Simplu installed.'


show_info ${ICON_INFO} 'Installing icons...'
mv "${INSTALL_FOLDER}icons/"* "${MAUTIC_FOLDER}media/images/"
show_info ${ICON_OK} 'Icons installed.'

chown -R www-data:www-data "${MAUTIC_FOLDER}"
chmod -R 755 "${MAUTIC_FOLDER}"
