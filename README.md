# The script is not working yet
I am not finished open-sourcing all the files and I plan to test afterwards. So at the moment, the installer is not working. When it will work, I will remove this text.

# Presentation
Installer script for Mautic V4 on VPS with Debian 12 is a bash script that allows you to install all that is needed for a fully production ready Mautic 4 instance. It can be used to install also up to 5x Mautic 4 instances on the same server.

# What is included
| INCLUDED | DESCRIPTION |
|--|--|
| `nginx` | Is used as web server |
| `apache2` | (web server) If `apache2` is found, then it will be uninstalled |
| `cron` | All needed cron jobs are optimally set (see below for a detailed description) |
| email notifications | In case that the execution of some cron jobs takes too long, notifications will be sent over email. In extreme cases the cron jobs will be stopped. |
| SSL / https | You can decide to pull a certificate needed for https, or a test certificate, if you want to test the installation beforehand |
| `php` version | You can choose which `php` version to install |
| mautic 4 version | You can choose which `mautic 4` version to install (the script is not suitable to install `mautic 5`) |
| [adminer evo](https://github.com/adminerevo/adminerevo) | Alternative to phpMyAdmin, to access detailed informations directly in the database |
| [commands.php](https://github.com/IonutOjicaDE/mautic-commands) | Utility that allows you to run different commands without `ssh` |
| passwords | All needed passwords are automatically created and you receive them over email. Please store the passwords securely (eg. using KeePass) |
| backup | Backups of the database and mautic folder are automatically created over night, last 7 backups are kept. |
| cache | Cache is automatically cleared/rebuild over night |
| permissions | Permissions of mautic folders are reseted over night |
| `mariadb` | `mariadb` is used as database |
| `mc` | `MidnightCommander` - orthodox File Explorer - is very usefull when accessing the server over `ssh` |
| dashboard | My dashboard is installed, that provide some usefull informations |
| theme | A very simple email template |
| icons | Some usefull icons of social platforms to use in your emails/landing pages |
| ro language | Romanian language pack (partially translated) (with some improvements from the online version) |
| `local.php` | Mautic will be already initialized |
| owner of contacts | New contacts will be assignet to first mautic user by default |
| `MauticAdvancedTemplatesBundle` | Plugin to enable `TWIG code` inside emails, landing pages and dynamic content |
| `MauticPostalServerBundle` | To be able to send emails trough `Postal API` (there is an open issue about the certification of the email) |
| `JotaworksDoiBundle` | DOI plugin |
| Mautic improvements | Active animation in multi-page forms, Show segment informations and Split of long lines on spaces also on smartphone, Send of the campaign emails using owner timezone, Remove button *Update now* from Notification, Correct Mautic auto log out each 10 minutes, Allow attribute `mautic:disable-tracking` in Dynamic Content, Fix the dynamic content events are not displayed on the lead timeline, remove `<style>.cke{visibility:hidden;}</style>` and `<div data-empty="true">` from the emails |
| `Froala` editor | The new 'mjml' editor is buggy and 'Froala' is used instead, although is a very old version |
| Firewall | By using `ufw`, only the ports ssh, http and https will be listened |
| BruteForce attacks on 'ssh' | By using `fail2ban`: after 3 wrong login attempts to ssh, 1 day block of respective IP-address |

As an inspiration I used the script [Matthias Reich](Info@Online-Business-Duplicator.de) made public here https://online-business-duplicator.de/mautic

These sources were also very useful:
* https://github.com/littlebizzy/slickstack/blob/master/bash/ss-install.txt
* https://stackoverflow.com/questions/16843382/colored-shell-script-output-library

# Execution
1. Create an account on [Hetzner](https://ionutojica.com/hetzner) (or DigitalCloud or AWS or ...) _(If you use my [affiliate link to create a Hetzner account](https://ionutojica.com/hetzner), you receive 20€ to use them for the server and I receive 10€ to pay for my servers)_
1. Create a VPS that has at minimum 2Gb RAM
    1. On [Hetzner](https://ionutojica.com/hetzner) you can choose `CX11` as server type
    1. Do not use Keys, but password authentification for `ssh` (you will receive the password from [Hetzner](https://ionutojica.com/hetzner) per email)
    1. Use `Debian 12` as the Operating System
    1. You can create also a Firewall and let ports 22 (ssh), 80 (http) and 443 (https) for the inside comunication open
1. Connect trough `ssh` to the server (I use [Termius](https://termius.com/))
1. Run as the root user:
    ```sh
    bash <(wget -qO- https://raw.githubusercontent.com/IonutOjicaDE/mautic4-installer/main/mautic-install.sh)
    ```

* the installer will automatically download and open the `config file` in the `nano` text editor, if the config file is not found in the current directory
* enter your values for each variable inside the config file, save it and exit the editor
* the script will check the values, the errors will be displayed and you will have the possibility to correct them in the text editor
* after no errors are found, a summary will be displayed. That will be the last point to stop the installation
* if you continue, Mautic will be installed, with all required packages
* all the passwords created will be sent per email
* finish: you can login into Mautic

# Configuration file
The configuration file is `mautic-install.conf` and is being searched by the installation script inside the same folder.

If it is not found, then a template configuration file will be downloaded from [github](https://raw.githubusercontent.com/IonutOjicaDE/mautic4-installer/main/mautic-install.conf) and will be opened using `nano` text editor (you can find some shortcuts for `nano` below).

## GENERAL CONFIGURATION
| VARIABLE | DESCRIPTION |
|--|--|
| MAUTIC_SUBDOMAIN | The subdomain where Mautic will be accessible, eg: `m.example.com` |
| SENDER_EMAIL | The email address from which Mautic will send emails, eg: `contact@example.com` |
| SENDER_FIRSTNAME | First name of the sender, eg: `Ionut` |
| SENDER_LASTNAME | Last name of the sender, eg: `Ojica` |
| SENDER_TIMEZONE | Your timezone, so that your clock is the same as in Mautic, eg. choose between: `'Europe/London'`, `'Europe/Berlin'`, `'Europe/Bucharest'`; you can find more timezones [here](https://www.php.net/manual/en/timezones.php) |

## INSTALLATION CONFIGURATION
| VARIABLE | DESCRIPTION |
|--|--|
| SSL_CERTIFICATE | Enter `'yes'` to obtain SSL certificate for production, `'test'` to obtain a test certificate, other value to not obtain any certificate |
| SEND_PASS_TO_SENDER_EMAIL | Enter `'yes'` to send the email with created passwords to `SENDER_EMAIL` and to `ADMIN_EMAIL`, other value will not send the email to `SENDER_EMAIL`, only to `ADMIN_EMAIL` |
| MAUTIC_COUNT | Commented line: will install first/main instance, values from `2` to `5`: install x count Mautic instance on the same server |
| MYSQL_ROOT_PASSWORD | if `MAUTIC_COUNT > 1` then we need the password of root user to MySQL database |
| ROOT_USER_PASSWORD | if `MAUTIC_COUNT > 1` then we need the password of root user on the server |
| PHP_VERSION | Mautic 4.4.11 works with php8.0 well, so enter `'8.0'` |
| MAUTIC_VERSION | the last *Mautic 4* version on 17.09.2024 is 4.4.12, so you could enter `'4.4.12'`. You can check for the last version [here](https://github.com/mautic/mautic/tags). This installation is not suitable for Mautic 5! |
| ADMINER_VERSION | the last AdminerEvo version on 17.09.2024 is 4.8.4, so you could enter `'4.8.4'`. You can check for the last version [here](https://github.com/adminerevo/adminerevo). |

## NOTIFICATION CONFIGURATION
| VARIABLE | DESCRIPTION |
|--|--|
| ADMIN_EMAIL | The email address of the admin, that will also receive the notification emails, eg: `admin@example.com` |
| FROM_EMAIL | The email address that will send the notification emails, eg: `install@example.com` |
| FROM_SERVER_PORT | Server and port to connect trough SMTP to send the notification emails, eg: `example.com:587` |
| FROM_USER | Username for the SMTP account, eg: `install@example.com` |
| FROM_PASS | Password for the SMTP account, eg: `MfE4KrGf%fH7PsW2$` |

# VPS
I use VPS from [Hetzner](https://ionutojica.com/hetzner). `CX11` is more than enough at the begining!

_(If you use my [affiliate link to create a Hetzner account](https://ionutojica.com/hetzner), you receive 20€ to use them for the server and I receive 10€ to pay for my servers)_

# Nano text editor
For those that are new to this editor, here are some shortcut keys:

| SHORTCUT | DESCRIPTION |
|--|--|
| `Ctrl+K` | delete current line |
| `Ctrl+S` | save the document |
| `Ctrl+X` | exit nano |
| right click | paste from clipboard |
| `Alt+#` | show line numbers (`Alt+#`=`Alt+Shift+3`) |
| `Alt+$` | wrap long lines (`Alt+$`=`Alt+Shift+4`) |

# Cronjobs
The main challange was to have the jobs run each second and to have them run one after the other, without any parallel executions.

This is done by the file `w-cron-all.sh` which executes `cron-all.php`.

Actually the purpose of all `w-`files is to have all the jobs run one after the other.

## cron-all.php
The actions executed by this cron job are:

| ACTION | SOFT LIMIT | HARD LIMIT | EACH MINUTES | DESCRIPTION |
|--|--|--|--|--|
| `webhook:process` | 30 | 110 | 1 | Process webhooks from the queue |
| `email:fetch --message-limit=100` | 30 | 110 | 10 | Check for Replies to sent emails |
| `reports:scheduler` | 30 | 110 | 60 | Send the scheduled reports by email |
| `segments:update --batch-limit=1000` | 30 | 110 | 1 | Update Lists / Segments in Mautic |
| `campaigns:rebuild --batch-limit=1000` | 30 | 110 | 1 | Keep campaigns updated with applicable contacts |
| `campaigns:trigger --batch-limit=1000` | 30 | 110 | 1 | Execute campaigns events |
| `broadcasts:send --limit=350` | 59 | 110 | 1 | Send scheduled broadcasts (segment emails) |
| `emails:send --message-limit=360` | 59 | 110 | 1 | Process email queue. If the system configuration is queueing emails, this cron job processes them |
| `import --limit=300` | 59 | 110 | 1 | Import contacts in the background |
| `messages:send` | 59 | 110 | 1 | Send scheduled marketing messages (emails or SMS) |

If the `Soft Limit` is exceeded, then an email will be sent out to the admin with this information.

If the `Hard Limit` is exceeded 5 times, then an email is sent to the admin and the cron jobs are stopped. You should check what is going on before restarting the cronjobs again.

Some jobs are not executed each minute, as these are either resource consuming (like `email:fetch`) or not needed (like `reports:scheduler`).

Some actions are executed only if there is a need for that, like `emails:send` or `import`.

## cron-backup.sh
This job is executed over night and automatically creates backups of the database and Mautic folder. Last 7 backups are kept.

## cron-clear-cache.php
Actually is self explicit: it clears the Mautic cache. This jobs is executed over night. With this cronjob we resolve many issues in Mautic.

## cron-database-optimization.sh
Removes `<style>.cke{visibility:hidden;}</style>` and `<div data-empty="true">` from the emails. These unnecessary code is added by `Froala` editor.

## cron-duplicate.php
You receive an email notification about the contacts found that have same email address (the search is done over night).

## cron-iplookup-download.php
The MaxMind database of the IP-lookup table is updated over night.

## cron-maintenance-cleanup.php
Older informations than 180 days is removed over night.

## reset-mautic-permissions.sh
Actually is self explicit: this job is executed from the crontab of the root user each night. With this cronjob we resolve many issues in Mautic.

## send-email.sh
This job sends the notification emails to the admin about the status of the cronjobs. If all the jobs are performing in limits, no emails are sent.

## DO--RUN
This file acts like a switch. If you rename the file to `DO-NOT-RUN`, then the `cron-all.php` will exit immediatelly.

This is usefull to disable all the cronjobs with a click. The switch is available also from the utility `commands.php` , which executes the file `switchCronJobs.sh` that renames the file from `DO--RUN` to `DO-NOT-RUN` and back.

## cron.lock
This file acts like an invisible signal: if a cronjob is already running, then any other cronjob will not start.

## clear-cache-done
For me was convenient from ssh:
* to just rename the file `clear-cache-done` to `clear-cache`
* to wait for the next execution of `cron-all.php` for:
  * the chache to be cleared
  * the correct permissions to be set
  * the file to be renamed back to `clear-cache-done`

This functionality is still implemented, although the cache can be cleared immediatelly by a click from the utility `commands.php`. Altough by using this file, the cache is cleared after all the cronjobs are executed, meaning no parallel executions are taking place.

# Folder structure
For the first Mautic instance, these are the folders used:

| FOLDER | DESCRIPTION |
|--|--|
| `/var/www/mautic/` | here is Mautic installed. Also the utility `commands.php` can be found here. |
| `/var/www/mautic/database/` | here is `Adminer` installed |
| `/var/mautic-crons/` | here are the cronjob files that are executed for Mautic |
| `/var/mautic-backups/` | here you can find the backups of the database and Mautic folder |
| `/usr/local/bin/reset-mautic-permissions.sh` | Here is the cronjob that will be executed using root user |

## Further Mautic instances
Here is where the second Mautic instance will be installed. For other Mautic instances will be analog to this.

| FOLDER | DESCRIPTION |
|--|--|
| `/var/www/mautic2/` | here is Mautic2 installed |
| `/var/www/mautic2/database/` | here is `Adminer` installed - this has no purpose, as one `Adminer` would be enough on the server. |
| `/var/mautic2-crons/` | here are the cronjob files that are executed for Mautic2 |
| `/var/mautic2-backups/` | here you can find the backups of the database and Mautic2 folder |
| `/usr/local/bin/reset-mautic2-permissions.sh` | Here is the cronjob that will be executed using root user |

# Adminer
`Adminer` will be accessible at https://mautic-subdomain/database/database.php . There you should enter the username (eg. `root`) and the password for the user (the password for the `root` user in MySQL database is saved under `MYSQL_ROOT_PASSWORD`).

Some plugins for Adminer are already installed: `edit-textarea`, `file-upload`, `foreign-system`, `tables-filter`, `tinymce`.

# Commands.php
The utility `commands.php` will be accessible at https://mautic-subdomain/commands.php . You enter the password you received as `MAUTIC_COMMANDS_PASSWORD` and you can choose the command you want to execute. You have also the possibility to personalize the command to execute.

This utility is [open sourced on github](https://github.com/IonutOjicaDE/mautic-commands) and can be updated/downgraded with a click from inside the utility.

Brute force atacks are not working with this utility, because after each wrong password entered, the blocking time is doubled. _This functionality would be great to be included in Mautic and Adminer._

# Live Webinar automation
With this installation you will have a fully functional live webinar automation, meaning all emails, campaigns, forms, segments are there and connected. You have to personalize the emails, insert the form to your landing page, set the date of the next webinar and let the interested contacts subscribe.

The name of these elements (emails, campaigns, forms, segments) is all in Romanian language.

Also all the contact fields inside Mautic are renamed in Romanian language.

# To do
1. The backup files are located only on the same server as Mautic - this is not good: if the server will be unavailable, the backups will not be accessible anymore. Upload to external cloud is needed, perhaps each 7-th day. [Hetzner](https://ionutojica.com/hetzner) (or DigitalCloud) can make also backups, but these are also on their servers - it is better to have an external backup also.
1. Include initialization of the VPS on [Hetzner](https://ionutojica.com/hetzner) (or DigitalCloud). Very usefull information is found here: https://github.com/escopecz/docker-compose-mautic
1. Automatically deduplicate contacts with the same email address. Now you receive only an email notification about the contacts found (the search is done over night).
1. Install only one Adminer. Now each Mautic installation has also an Adminer installed, although one is enough. Adminer is <500kB so this issue is low priority.
1. During installation, we download each mini-script at a time and execute it. Download whole repository as a zip and execute the scripts from there.

If my work has been useful to you, do not hesitate to offer me a strawberry milk 😃

[!["Buy Me A Coffee"](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png)](https://www.buymeacoffee.com/ionutojica)
