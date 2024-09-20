#!/bin/bash

###############################################################################
#                                                                             #
# Install ufw and fail2ban                                                    #
#                                                                             #
###############################################################################

if [ ! -z "${MAUTIC_COUNT}" ] || [ "${MAUTIC_COUNT}" -eq 1 ]; then
  if dpkg -l | grep -qw ufw; then
    show_info ✅ 'Ufw (Firewall) is already installed.'
  else
    show_info ❌ "Error: Ufw (Firewall) should already be installed, when installing ${MAUTIC_COUNT} instance of Mautic !"
    exit 1
  fi
  if dpkg -l | grep -qw fail2ban; then
    show_info ✅ 'fail2ban is already installed.'
  else
    show_info ❌ "Error: fail2ban should already be installed, when installing ${MAUTIC_COUNT} instance of Mautic !"
    exit 1
  fi
else

  show_info 🛈 'Installing ufw (Firewall)...'
  DEBIAN_FRONTEND=noninteractive apt-get -yq install ufw
  ufw allow ssh 
  ufw allow 80
  ufw allow 443
  ufw --force enable
  show_info ✅ 'ufw (Firewall) is installed.'

  show_info 🛈 'Installing fail2ban (against BruteForce attacks)...'
  DEBIAN_FRONTEND=noninteractive apt-get -yq install fail2ban
  cp /etc/fail2ban/jail.{conf,local}
  sed -i "s|bantime  = 10m|bantime  = 1d|g" /etc/fail2ban/jail.local
  systemctl restart fail2ban
  show_info ✅ 'fail2ban is installed.'

fi
