#!/bin/bash

###############################################################################
#                                                                             #
# Install plugins                                                             #
#                                                                             #
###############################################################################

show_info 🛈 'Installing commands.php...'
wget -q 'https://github.com/IonutOjicaDE/mautic-commands/archive/refs/heads/main.zip' -O commands.zip
unzip -q commands.zip -d "${MAUTIC_FOLDER}commands/"
rm commands.zip
sed -i "s|/var/mautic-crons/|${CRON_FOLDER}|g" "${MAUTIC_FOLDER}commands/commands.php"
show_info ✅ 'commands.php is installed.'


show_info 🛈 'Installing Plugin: MauticAdvancedTemplatesBundle...'
wget -q 'https://github.com/IonutOjicaDE/MauticAdvancedTemplatesBundle/archive/refs/heads/master.zip' -O MauticAdvancedTemplatesBundle.zip
unzip -q MauticAdvancedTemplatesBundle.zip -d "${MAUTIC_FOLDER}plugins/MauticAdvancedTemplatesBundle/"
rm MauticAdvancedTemplatesBundle.zip
show_info ✅ 'Plugin: MauticAdvancedTemplatesBundle is installed.'


show_info 🛈 'Installing Plugin: MauticPostalServerBundle...'
wget -q 'https://github.com/IonutOjicaDE/MauticPostalServerBundle/archive/refs/heads/master.zip' -O MauticPostalServerBundle.zip
unzip -q MauticPostalServerBundle.zip -d "${MAUTIC_FOLDER}plugins/MauticPostalServerBundle/"
rm MauticPostalServerBundle.zip
show_info ✅ 'Plugin: MauticPostalServerBundle is installed.'


show_info 🛈 'Installing Plugin: JotaworksDoiBundle...'
wget -q 'https://github.com/IonutOjicaDE/mautic-doi-plugin/archive/refs/heads/main.zip' -O JotaworksDoiBundle.zip
unzip -q JotaworksDoiBundle.zip
mv "mautic-doi-plugin-main/src/JotaworksDoiBundle" "${MAUTIC_FOLDER}plugins/"
rm mautic-doi-plugin-main
rm JotaworksDoiBundle.zip
show_info ✅ 'Plugin: JotaworksDoiBundle is installed.'

show_info 🛈 'Reset permissions...'
chown -R www-data:www-data "${MAUTIC_FOLDER}plugins/"
chmod -R 755 "${MAUTIC_FOLDER}plugins/"

show_info 🛈 'Clearing cache...'
php "${MAUTIC_FOLDER}bin/console cache:clear --no-interaction --no-warmup"

chown -R www-data:www-data "${MAUTIC_FOLDER}"
chmod -R 755 "${MAUTIC_FOLDER}"

show_info 🛈 'Reload plugins in Mautic...'
php "${MAUTIC_FOLDER}bin/console mautic:plugins:reload"
show_info ✅ 'Plugins reloaded in Mautic.'
