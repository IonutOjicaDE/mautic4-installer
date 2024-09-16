#!/bin/bash

###############################################################################
#                                                                             #
# Install plugins                                                             #
#                                                                             #
###############################################################################

show_info 🛈 'Installing Plugin: MauticAdvancedTemplatesBundle...'
wget -q $URL_TO_FILES'MauticAdvancedTemplatesBundle.zip'
unzip -q MauticAdvancedTemplatesBundle.zip -d $MAUTIC_FOLDER'plugins/'
rm MauticAdvancedTemplatesBundle.zip
show_info ✅ 'Plugin: MauticAdvancedTemplatesBundle is installed.'


show_info 🛈 'Installing Plugin: MauticPostalServerBundle...'
wget -q $URL_TO_FILES'MauticPostalServerBundle.zip'
unzip -q MauticPostalServerBundle.zip -d $MAUTIC_FOLDER'plugins/'
rm MauticPostalServerBundle.zip
show_info ✅ 'Plugin: MauticPostalServerBundle is installed.'


show_info 🛈 'Installing Plugin: JotaworksDoiBundle...'
wget -q $URL_TO_FILES'JotaworksDoiBundle.zip'
unzip -q JotaworksDoiBundle.zip -d $MAUTIC_FOLDER'plugins/'
rm JotaworksDoiBundle.zip
show_info ✅ 'Plugin: JotaworksDoiBundle is installed.'

show_info 🛈 'Reset permissions...'
chown -R www-data:www-data $MAUTIC_FOLDER'plugins/'
chmod -R 755 $MAUTIC_FOLDER'plugins/'

show_info 🛈 'Clearing cache...'
php ${MAUTIC_FOLDER}bin/console cache:clear --no-interaction --no-warmup

chown -R www-data:www-data $MAUTIC_FOLDER
chmod -R 755 $MAUTIC_FOLDER

show_info 🛈 'Reload plugins in Mautic...'
php ${MAUTIC_FOLDER}bin/console mautic:plugins:reload
show_info ✅ 'Plugins reloaded in Mautic.'
