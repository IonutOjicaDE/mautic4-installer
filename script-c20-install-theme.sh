#!/bin/bash

###############################################################################
#                                                                             #
# Install Theme                                                               #
#                                                                             #
###############################################################################

show_info 🛈 'Downloading Dashboard...'
wget -q "${URL_TO_FILES}dashboard-20231009.json"
cp dashboard-20231009.json $MAUTIC_FOLDER'media/dashboards/'
rm dashboard-20231009.json
show_info ✅ 'Dashboard installed.'

show_info 🛈 'Downloading Theme...'
wget -q $URL_TO_FILES'460c-Simplu.zip'
unzip -q 460c-Simplu.zip -d $MAUTIC_FOLDER'themes/460c-Simplu/'
rm 460c-Simplu.zip
show_info ✅ 'Theme installed.'

show_info 🛈 'Downloading icons...'
wget -q $URL_TO_FILES'icons.zip'
unzip -q icons.zip -d $MAUTIC_FOLDER'media/images/'
rm icons.zip
show_info ✅ 'Icons installed.'

chown -R www-data:www-data $MAUTIC_FOLDER
chmod -R 755 $MAUTIC_FOLDER
