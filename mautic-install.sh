#!/bin/bash

###############################################################################################
#####                                INSTALL MAUTIC 4 SCRIPT                              #####
#####                                    BY IONUT OJICA                                   #####
#####                                    IONUTOJICA.COM                                   #####
###############################################################################################


#Run with: bash <(wget -qO- https://raw.githubusercontent.com/IonutOjicaDE/mautic4-installer/main/mautic-install.sh)
# ✅ ❌ ❓ ❗ ❎ ⛔ 🛈


###############################################################################################
#####                                   GET CONFIG FILE                                   #####
###############################################################################################
URL_TO_FILES='https://raw.githubusercontent.com/IonutOjicaDE/mautic4-installer/main/'
PWD="$(pwd)/"
FILE_CONF='mautic-install.conf'

install_script_files=(
  'script-a10-definitions.sh'
  'script-a20-precheck.sh'
  'script-a30-input-values.sh'
  'script-a40-create-pass.sh'
  'script-b10-update-nginx-mariadb.sh'
  'script-b20-install-php-default-conf.sh'
  'script-b30-install-mautic.sh'
  'script-b40-install-adminer.sh'
  'script-c10-database-certbot.sh'
  'script-c20-install-theme.sh'
  'script-c30-mysql-localphp.sh'
  'script-c32-mysql-owner.sh'
  'script-c40-plugins.sh'
  'script-d10-adjusting.perl'
  'script-e10-ufw-fail2ban.sh'
  'script-e20-crons.sh'
  'script-e30-send-pass-to-email.sh'
  'script-e40-summary.sh'
)

for install_script_file in "${install_script_files[@]}"; do
  wget -q "${URL_TO_FILES}${install_script_file}"
  if [[ "${install_script_file}" == *.sh ]]; then
    source "${install_script_file}"
  elif [[ "${install_script_file}" == *.perl ]]; then
    perl -s "${install_script_file}" "${MAUTIC_FOLDER}" "${MAUTIC_SUBDOMAIN}"
    cp "${install_script_file}" "${CRON_FOLDER}"
  fi
done

for install_script_file in "${install_script_files[@]}"; do
  rm "${install_script_file}"
done
rm 'mautic-install-config.sh'


####################################################################################
#              IonutOjica: External resources to create the script:                #
#                                                                                  #
# Source script from Matthias Reich - Info@Online-Business-Duplicator.de           #
# https://online-business-duplicator.de/mautic                                     #
#                                                                                  #
# https://github.com/littlebizzy/slickstack/blob/master/bash/ss-install.txt        #
#                                                                                  #
# https://stackoverflow.com/questions/16843382/colored-shell-script-output-library #
#                                                                                  #
####################################################################################
