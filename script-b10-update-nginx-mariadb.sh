#!/bin/bash

###############################################################################
#                                                                             #
# Install nginx, MariaDb                                                      #
#                                                                             #
###############################################################################

if [ ! -z "$MAUTIC_COUNT" ] || [ "$MAUTIC_COUNT" -eq 1 ]; then
  if dpkg -l | grep -qw nginx; then
    show_info ✅ 'Nginx is already installed.'
  else
    show_info ❌ "Error: Nginx should already be installed, when installing $MAUTIC_COUNT instance of Mautic !"
    exit 1
  fi
  if dpkg -l | grep -qw mariadb; then
    show_info ✅ 'MariaDB is already installed.'
  else
    show_info ❌ "Error: MariaDB should already be installed, when installing $MAUTIC_COUNT instance of Mautic !"
    exit 1
  fi
else

  show_info 🛈 'Enable autentification using password for root user'
  echo "root:$ROOT_USER_PASSWORD" | chpasswd
  sed -i 's/^#\?PermitRootLogin .*/PermitRootLogin yes/' /etc/ssh/sshd_config
  sed -i 's/^#\?PasswordAuthentication .*/PasswordAuthentication yes/' /etc/ssh/sshd_config
  systemctl restart sshd


  show_info 🛈 'Time zone of the operating system must remain Etc/UTC'
  timedatectl set-timezone "Etc/UTC"

  show_info 🛈 'Installing nginx...'
  DEBIAN_FRONTEND=noninteractive apt-get -yq install nginx htop
  #Enable autostart of nginx on every reboot
  systemctl enable nginx
  #Start nginx now
  systemctl start nginx
  #Assure the correct permissions
  chown www-data:www-data /usr/share/nginx/html -R
  show_info ✅ 'Nginx is installed.'


  show_info 🛈 'Installing MariaDB...'
  DEBIAN_FRONTEND=noninteractive apt-get -yq install mariadb-server mariadb-client
  #Enable autostart of MariaDB on every reboot
  systemctl enable mariadb

mysql_secure_installation <<EOF
y
$MYSQL_ROOT_PASSWORD
$MYSQL_ROOT_PASSWORD
y
y
y
y
y
EOF

  show_info ✅ 'MariaDB is installed.'
  
fi
