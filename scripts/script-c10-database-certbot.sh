#!/bin/bash

###############################################################################################
#####        Create database, Nginx configuration file and pull ssl certificate           #####
###############################################################################################


show_info ${ICON_INFO} "Create mautic${MAUTIC_COUNT} and user mauticuser${MAUTIC_COUNT} database..."

#database named "mautic" will be created
#username "mauticuser" will be created
#with the password "MYSQL_MAUTICUSER_PASSWORD"
echo "CREATE DATABASE mautic${MAUTIC_COUNT} DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;GRANT ALL ON mautic${MAUTIC_COUNT}.* TO 'mauticuser${MAUTIC_COUNT}'@'localhost' IDENTIFIED BY '${MYSQL_MAUTICUSER_PASSWORD}';FLUSH PRIVILEGES;" | mysql -u root -p${MYSQL_ROOT_PASSWORD}

show_info ${ICON_OK} 'Mautic database created.'


file_content="$(cat << EOF
server {
  listen 80;
  listen [::]:80;

  server_name ${MAUTIC_SUBDOMAIN};

  root ${MAUTIC_FOLDER};
  error_log /var/log/nginx/mautic${MAUTIC_COUNT}.error;
  access_log /var/log/nginx/mautic${MAUTIC_COUNT}.access;
  client_max_body_size 512M;

  index index.php index.html index.htm index.nginx-debian.html;

  location / {
    # try to serve file directly, fallback to app.php
    try_files \$uri /index.php\$is_args\$args;
  }

  location ~ /(mtc.js|1.js|mtracking.gif|.*\.gif|mtc) {
    # default_type "application/javascript";
    try_files \$uri /index.php\$is_args\$args;
  }

  # redirect some entire folders
  rewrite ^/(vendor|translations|build)/.* /index.php break;

  location ~ \.php$ {
    include snippets/fastcgi-php.conf;
    fastcgi_pass unix:/run/php/php${PHP_VERSION}-fpm.sock;
  }

  location ~* ^/(index.php|commands/commands.php|database/database.php) {
    # try_files \$uri =404;
    fastcgi_split_path_info ^(.+\.php)(/.+)$;
    # NOTE: You should have "cgi.fix_pathinfo = 0;" in php.ini

    fastcgi_pass unix:/var/run/php/php${PHP_VERSION}-fpm.sock;
    fastcgi_index index.php;
    fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
    include fastcgi_params;

    fastcgi_buffer_size 128k;
    fastcgi_buffers 256 16k;
    fastcgi_busy_buffers_size 256k;
    fastcgi_temp_file_write_size 256k;
  }

  # Allow acces to thumbnails trough Elfinder
  location ~ /media/images/.tmb/ {
    allow all;
    access_log off;
  }

  # Deny everything else in /app folder except Assets folder in bundles
  location ~ /app/assets/* {
    allow all;
    access_log off;
  }

  location ~ /app/bundles/.*/Assets/ {
    allow all;
    access_log off;
  }
  location ~ /app/ { deny all; }

  # Deny everything else in /addons or /plugins folder except Assets folder in bundles
  location ~ /(addons|plugins)/.*/Assets/ {
    allow all;
    access_log off;
  }
  # location ~ /(addons|plugins)/ { deny all; }

  # Deny all php files in themes folder
  location ~* ^/themes/(.*)\.php {
    deny all;
  }

  # Don't log favicon
  location = /favicon.ico {
    log_not_found off;
    access_log off;
  }

  # Don't log robots
  location = /robots.txt  {
    access_log off;
    log_not_found off;
  }

  # Deny yml, twig, markdown, init file access
  location ~* /(.*)\.(?:markdown|md|twig|yaml|yml|ht|htaccess|ini)$ {
    deny all;
    access_log off;
    log_not_found off;
  }

  # Allow access to certbot directory in order to obtain TLS certificate
  location ~ /.well-known/acme-challenge {
    allow all;
  }

  # Deny all attempts to access hidden files/folders such as .htaccess, .htpasswd, .DS_Store (Mac), etc...
  location ~ /\. {
    deny all;
    access_log off;
    log_not_found off;
  }

  # Deny all grunt, composer files
  location ~* (Gruntfile|package|composer)\.(js|json)$ {
    deny all;
    access_log off;
    log_not_found off;
  }

  # Deny access to any files with a .php extension in the uploads directory
  location ~* /(?:uploads|files)/.*\.php$ {
    deny all;
  }

  # A long browser cache lifetime can speed up repeat visits to your page
  location ~* \.(jpg|jpeg|gif|png|webp|svg|woff|woff2|ttf|css|js|ico|xml)$ {
    access_log        off;
    log_not_found     off;
    expires           360d;
  }
}
EOF
)"
mautic_conf_file="/etc/nginx/conf.d/mautic${MAUTIC_COUNT}.conf"
echo "${file_content}" > "${mautic_conf_file}"
systemctl reload nginx

show_info ${ICON_OK} 'Nginx configuration file for Mautic (mautic.conf) created.'


if [ "${SSL_CERTIFICATE,,}" == "test" ] || [ "${SSL_CERTIFICATE,,}" == "yes" ]; then
  show_info ${ICON_INFO} 'We will try to obtain a SSL certificate...'

  DEBIAN_FRONTEND=noninteractive apt-get -yq install certbot python3-certbot-nginx
  mkdir -p "${MAUTIC_FOLDER}.well-known/acme-challenge"
  chown www-data:www-data "${MAUTIC_FOLDER}.well-known/acme-challenge"
  #To pull the certificate during debuging: --test-cert
  #To test if a certificate can be pulled: --dry-run
  #https://letsencrypt.org/docs/staging-environment/

  if [ "${SSL_CERTIFICATE,,}" == "yes" ]; then
    show_info ${ICON_INFO} 'Pull production SSL certificate...'
    certbot --nginx --agree-tos --redirect --hsts --staple-ocsp --no-eff-email --email ${SENDER_EMAIL} -d ${MAUTIC_SUBDOMAIN}
  else
    show_info ${ICON_INFO} 'Debug mode enabled: we will use the option --test-cert to obtain a SSL certificate...'
    certbot --nginx --agree-tos --redirect --hsts --staple-ocsp --no-eff-email --email ${SENDER_EMAIL} -d ${MAUTIC_SUBDOMAIN} --test-cert
  fi
  #The certificate can be removed with: certbot delete --cert-name ${MAUTIC_SUBDOMAIN}

  if [ $? -eq 0 ]; then
    show_info ${ICON_OK} 'SSL certificate was pulled successfully.'
  else
    show_info ${ICON_ERR} 'There is an error and the SSL certificate was not obtained. Do you want to continue?'
    answer_yes_else_stop
  fi

  #HTTP/2 protocol improves performance, including page loading speed and efficiency of connexions management
  sed -i 's/listen 443 ssl/listen 443 ssl http2/' "${mautic_conf_file}"
  sed -i 's/listen \[::\]:443 ssl/listen \[::\]:443 ssl http2/' "${mautic_conf_file}"
  systemctl reload nginx
else
  show_info ${ICON_OK} 'No SSL certificate will be pulled.'
fi

