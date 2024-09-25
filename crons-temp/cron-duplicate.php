<?php

ob_start(); // prevent output anything
$currentDir = __DIR__;
require_once $currentDir . '/mautic.php';
ob_get_clean();

$date_hour = date("Y-m-d H:i:s");
$result    = shell_exec('php /var/www/mautic' . $MAUTIC_COUNT . '/bin/console doctrine:query:sql "SELECT COUNT(email) AS count, email, GROUP_CONCAT(id) AS ids FROM leads WHERE email IS NOT NULL AND email != \'\' GROUP BY email HAVING COUNT(email) > 1;"');

$lines     = explode("\n", $result);
$firstLine = $lines[0];

$start     = strpos($firstLine, "array(") + 6; // +6 pentru a sări peste 'array('
$end       = strpos($firstLine, ")", $start);
$count     = substr($firstLine, $start, $end - $start);
$subject   = "";
$content   = "Hello $SENDER_FIRSTNAME,\n\n";

if ($count == '0') {
  //echo "Great, there are no duplicate contacts.\n";
  exit;
} elseif ($count == '1') {
  $subject = "ACTION Mautic ${MAUTIC_SUBDOMAIN}: Contacts with the same email address";
  $content .=  "in the database we found contacts with the same email address - do not delay to check them and only one of them remains:\n\n";
} else {
  $subject = "ACTION Mautic ${MAUTIC_SUBDOMAIN}: ${count} email addresses are used by several contacts";
  $content .= "in the database we found ${count} email addresses that are used by several contacts - do not delay to check them and delete them so that only one contact remains for each email address:\n\n";
}

// process line by line until the (last-1) line
for ($i = 0; $i < count($lines) - 1; $i++) {
  $currentLine = trim($lines[$i]); // clean the line of white spaces
  
  switch ($currentLine) {
    case '["count"]=>':
      $currentLine = trim($lines[++$i]); // jump to the next line and clean it
      preg_match('/"([^"]+)"/', $currentLine, $matches);  // extract the text between the quotation marks
      if (!empty($matches[1])) {
        $count = $matches[1];  // save the extracted number
        $content .= "  Are ${count} contacts with email address ";
      }
      break;

    case '["email"]=>':
      $currentLine = trim($lines[++$i]); // jump to the next line and clean it
      preg_match('/"([^"]+)"/', $currentLine, $matches);  // extract the text between the quotation marks
      if (!empty($matches[1])) {
        $email = $matches[1];  // save the extracted number
        $content .= "${email} , with ID-s:\n";
      }
      break;

    case '["ids"]=>':
      $currentLine = trim($lines[++$i]); // jump to the next line and clean it
      preg_match('/"([^"]+)"/', $currentLine, $matches);  // extract the text between the quotation marks
      if (!empty($matches[1])) {
        $ids = explode(",",$matches[1]);  // save the extracted ID-s
        foreach($ids as $id) {
          $content .= "    ID ${id} accessible at https://${MAUTIC_SUBDOMAIN}/s/contacts/view/${id}\n";
        }
        $content .= "\n";
      }
      break;
  }
}
$content .= "Have a great time!\nScript cron-duplicate.php\n";

$message_file = $currentDir . '/cron-duplicate.mail';
$file         = fopen("${message_file}", "w");

fwrite($file, "Subject: ${subject}\n");
fwrite($file, "From: ${FROM_EMAIL}\n");
fwrite($file, "To: ${ADMIN_EMAIL}\n");
fwrite($file, "Content-Type: text/plain; charset=utf-8\n\n");
fwrite($file, $content);
fwrite($file, "\nPS: Checking date and time: ${date_hour}");
fclose($file);

$cmd = "sendemail -f ${FROM_EMAIL} -s ${FROM_SERVER_PORT} -xu ${FROM_USER} -xp '${FROM_PASS}' -t ${ADMIN_EMAIL} -o message-format=raw -o message-file=${message_file}";
$cmd .= ' > /dev/null 2>&1'; // No output; uncoment if output is needed

shell_exec($cmd);

?>
