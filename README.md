# mautic4-installer
Here I will open source my installer script for Mautic V4 on VPS with Debian 12.

As an inspiration I used the script from Matthias Reich - Info@Online-Business-Duplicator.de : https://online-business-duplicator.de/mautic

Also following other sources were very useful:
* https://github.com/littlebizzy/slickstack/blob/master/bash/ss-install.txt
* https://stackoverflow.com/questions/16843382/colored-shell-script-output-library

# Execution
Run on the VPS as the root user with:
```bash
bash <(wget -qO- https://raw.githubusercontent.com/IonutOjicaDE/mautic-commands/main/mautic-install.sh)
```

* the installer will ask you for the config file
* choose to download and open the config file in the editor (nano)
* enter your values for each variable, save and exit the editor
* the script will check the values, the errors will be displayed and you will have the possibility to correct them in the editor
* after no errors are found, a summary will be displayed. That will be the last point to stop the installation.
* if you continue, Mautic will be installed.
* all the passwords created will be sent per email.
