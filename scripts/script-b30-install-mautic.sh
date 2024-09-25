#!/bin/bash

###############################################################################################
#####                                 Install Mautic                                      #####
###############################################################################################

show_info ${ICON_INFO} 'Download Mautic...'

mkdir -p "${MAUTIC_FOLDER}"

DEBIAN_FRONTEND=noninteractive apt-get -yq install unzip zip
wget -q "${MAUTIC_DOWNLOAD_URL}"

show_info ${ICON_INFO} 'Unzip Mautic...'
unzip -q "${MAUTIC_VERSION}.zip" -d "${MAUTIC_FOLDER}"
rm "${MAUTIC_VERSION}.zip"

chown -R www-data:www-data "${MAUTIC_FOLDER}"
chmod -R 755 "${MAUTIC_FOLDER}"

show_info ${ICON_OK} 'Mautic is installed.'
