<?php
ob_start(); // prevent output anything
require_once __DIR__ . '/mautic.php';
ob_get_clean();

$cmd = '/usr/bin/php ' . ${MAUTIC_FOLDER} . 'bin/console mautic:iplookup:download';
$cmd .= ' > /dev/null 2>&1'; // No output; uncoment if output is needed
shell_exec($cmd);
// /usr/bin/php /var/www/mautic/bin/console mautic:iplookup:download

?>