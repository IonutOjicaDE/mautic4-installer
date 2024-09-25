
php /var/www/mautic/bin/console mautic:webhook:process

//update Lists / Segments in Mautic, default --batch-limit=300 --max-contacts=
php /var/www/mautic/bin/console mautic:segments:update --batch-limit=1000

//check for Replies to sent emails, default --message-limit=
php /var/www/mautic/bin/console mautic:email:fetch --message-limit=100

//To keep campaigns updated with applicable contacts, default --batch-limit=100 --max-contacts=
php /var/www/mautic/bin/console mautic:campaigns:rebuild --batch-limit=1000

//To execute campaigns events, default  --batch-limit=100 --max-events=
php /var/www/mautic/bin/console mautic:campaigns:trigger --batch-limit=1000

//Send scheduled broadcasts (segment emails), default --limit=100 --batch=
php /var/www/mautic/bin/console mautic:broadcasts:send --limit=350

//Process email queue. If the system configuration is queueing emails, this cron job processes them
php /var/www/mautic/bin/console mautic:emails:send --message-limit=360

//Import contacts in the background
php /var/www/mautic/bin/console mautic:import --limit=300

//Trimiterea de mesaje (email sau SMS) de marketing, cand sunt programate
php /var/www/mautic/bin/console mautic:messages:send


//clear cache
php /var/www/mautic/bin/console cache:clear --no-interaction --no-warmup

//set the file owner recursively -R for the user and the www-data group, which is responsible for running PHP through its web server
chown -R www-data:www-data /var/www/mautic/

//modifies the access permissions to the files saying that the www-data group has written and read access
//Opțiunea -R indică faptul că chmod ar trebui să aplice aceste permisiuni recursiv la directorul specificat și la toate conținuturile sale.
chmod -R 755 /var/www/mautic/

mkdir -p /var/mautic-backups
mv /root/cron-backups/* /var/mautic-backups/
chown -R www-data:www-data /var/mautic-crons/
chown -R www-data:www-data /var/mautic-backups/
chmod -R 755 /var/mautic-crons/
chmod -R 755 /var/mautic-backups/
crontab -u www-data crons

//redo cache
php /var/www/mautic/bin/console cache:warmup --no-interaction


//actualizeaza baza de IP-uri
php /var/www/mautic/bin/console mautic:iplookup:download

//curata baza de date
php /var/www/mautic/bin/console mautic:maintenance:cleanup --days-old=365 --no-interaction
