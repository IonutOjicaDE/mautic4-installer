<?php

ob_start(); // prevent output anything
require_once __DIR__ . '/mautic.php';
ob_get_clean();

$clearCacheFile     = "${CRON_FOLDER}clear-cache";
$cacheClearedFile   = "${clearCacheFile}-done";
$clearCacheCronFile = "${CRON_FOLDER}cron-clear-cache.php";
$DO_RUN_File        = "${CRON_FOLDER}DO--RUN";
$DO_NOT_RUN_File    = "${CRON_FOLDER}DO-NOT-RUN";

if (file_exists($DO_NOT_RUN_File)) { goto finish; }

$currentMinutes     = date('G') * 60 + date('i'); // Current minute from midnight
$softExceedFile     = "${CRON_FOLDER}log/crons-" . date('Y-m-d') . '.csv';
$hardExceedFile     = "${CRON_FOLDER}crons-warning.csv";
$hardExceedTimes    = 5;
$run_console        = "/usr/bin/php ${MAUTIC_FOLDER}bin/console mautic:";

$commands = [
// Process webhooks from the queue - UNCOMENT if webhooks are used
"webhook:process" => ["softTimeLimit" => 30, "hardTimeLimit" => 110, "folder" => "", "eachMinutes" => 1],

// Check for Replies to sent emails, default --message-limit=
"email:fetch --message-limit=100" => ["softTimeLimit" => 30, "hardTimeLimit" => 110, "folder" => "", "eachMinutes" => 10],

// Send the scheduled reports by email
"reports:scheduler" => ["softTimeLimit" => 30, "hardTimeLimit" => 110, "folder" => "", "eachMinutes" => 60],

// Update Lists / Segments in Mautic, default --batch-limit=300 --max-contacts=
"segments:update --batch-limit=1000" => ["softTimeLimit" => 30, "hardTimeLimit" => 110, "folder" => "", "eachMinutes" => 1],

// Keep campaigns updated with applicable contacts, default --batch-limit=100 --max-contacts=
"campaigns:rebuild --batch-limit=1000" => ["softTimeLimit" => 30, "hardTimeLimit" => 110, "folder" => "", "eachMinutes" => 1],

// Execute campaigns events, default  --batch-limit=100 --max-events=
"campaigns:trigger --batch-limit=1000" => ["softTimeLimit" => 30, "hardTimeLimit" => 110, "folder" => "", "eachMinutes" => 1],

// Send scheduled broadcasts (segment emails), default --limit=100 --batch=
"broadcasts:send --limit=350" => ["softTimeLimit" => 59, "hardTimeLimit" => 110, "folder" => "", "eachMinutes" => 1],

// Process email queue. If the system configuration is queueing emails, this cron job processes them
"emails:send --message-limit=360" => ["softTimeLimit" => 59, "hardTimeLimit" => 110, "folder" => "${MAUTIC_FOLDER}var/spool", "eachMinutes" => 1],

// Import contacts in the background
"import --limit=300" => ["softTimeLimit" => 59, "hardTimeLimit" => 110, "folder" => "${MAUTIC_FOLDER}var/tmp/imports", "eachMinutes" => 1],

// Send scheduled marketing messages (emails or SMS)
"messages:send" => ["softTimeLimit" => 59, "hardTimeLimit" => 110, "folder" => "", "eachMinutes" => 1]
];
$logs             = [];
$softTimeExceeded = false;
$hardTimeExceeded = false;

foreach ($commands as $command => $info) {
  $result = executeCommand($run_console, $command, $info, $currentMinutes);
  $logs[$command] = ['duration' => $result['duration'], 'output' => $result['output']];

  if ($result['duration'] >= $info['softTimeLimit']) {
    $softTimeExceeded = true;
    if ($result['duration'] >= $info['hardTimeLimit']) { $hardTimeExceeded = true; }
  }
}

if ($softTimeExceeded) { writeToCsv($softExceedFile, $commands, $logs); }
if ($hardTimeExceeded) { writeToCsv($hardExceedFile, $commands, $logs, $hardExceedTimes); }

finish:

if (file_exists($clearCacheFile)) {
 ob_start(); // prevent output anything
 $t = include "${clearCacheCronFile}";
 ob_get_clean();
 rename($clearCacheFile, $cacheClearedFile);
}

// Used custom functions:

function writeToCsv($exceedFilename, $commands, $logs, $hardExceedTimes = null) {
  $logFile = fopen($exceedFilename, 'a+') or die('Unable to open file.');

  if (is_null($hardExceedTimes)) {
    fseek($logFile, 0, SEEK_END); $initialLines = ftell($logFile) == 0 ? 0 : -1;
  } else {
    rewind($logFile); $initialLines = 0; while (!feof($logFile)) { fgets($logFile); $initialLines++; }
  }

  if ($initialLines == 0) {
    fputcsv($logFile, array_merge(['TimeFinished'], array_keys($commands)));
    fputcsv($logFile, array_merge(['SoftTimeLimit'], array_column($commands, 'softTimeLimit')));
    fputcsv($logFile, array_merge(['HardTimeLimit'], array_column($commands, 'hardTimeLimit')));
  }
  fputcsv($logFile, array_merge([date("Y-m-d H:i:s")], array_column($logs, 'duration')));
  fclose($logFile);

  if (!is_null($hardExceedTimes) && ($initialLines - 3) >= $hardExceedTimes) {
    if (file_exists($DO_RUN_File)) { rename($DO_RUN_File, $DO_NOT_RUN_File);
    } else { touch($DO_NOT_RUN_File); }
  }
}

function executeCommand($run_console, $command, $info, $currentMinutes) {
  if ($currentMinutes % $info['eachMinutes'] == 0 && areFilesInFolder($info['folder'])) {
    $start = microtime(true);             // Start counting
    $cmd = "timeout " . $info['hardTimeLimit'] . " " . $run_console . $command; // Prepare command to execute
    $cmd .= ' > /dev/null 2>&1';          // No output; uncoment if output is needed
    $output = shell_exec($cmd);           // Execute command
    $duration = microtime(true) - $start; // Calculate duration
  } else {
    $duration = 0;
    $output = '';
  }
  return ['duration' => $duration, 'output' => $output];
}

function areFilesInFolder($dir) {
  if ($dir == "" || !is_dir($dir) || !is_readable($dir)) { return true; }
  $handle = opendir($dir);
  while (false !== ($entry = readdir($handle))) {
    if ($entry != "." && $entry != "..") { closedir($handle); return true; }
  }
  closedir($handle); return false;
}

?>
