#!/bin/bash -e
current_dir=$(dirname "$(readlink -f "$0")")
log_file="${current_dir}/crons-warning.csv"

if [ -s $log_file ]; then
  # The file is not-empty.
  source ${current_dir}/mautic.sh

  if [ -e "${current_dir}/DO-NOT-RUN" ]; then
    subject="ACTION Mautic $MAUTIC_SUBDOMAIN: The commands took too long and their execution is stopped"
    content=$(cat <<EOL
Hello ${SENDER_FIRSTNAME},

EXECUTION OF COMMANDS FROM MAUTIC $MAUTIC_SUBDOMAIN IS STOPPED

because we noticed that repeatedly certain commands took longer than specified as hardLimit.
Attached is the recorded log where you can check which command exceeded the execution time.

Exceeding the execution time is a sign that there is an error in Mautic.

Before restarting command execution:
* check the attached log
* execute the command via SSH and check the output
* then correct the error

Success!
Script $(readlink -f "$0")

PS: Date and time of verification: $(date +'%Y-%m-%d %H:%M:%S')
EOL
)
  else
    subject="ACTIUNE Mautic $MAUTIC_SUBDOMAIN: The commands took too long and their execution will be stopped"
    content=$(cat <<EOL
Hello ${SENDER_FIRSTNAME},

we noticed that on the domain $MAUTIC_SUBDOMAIN certain commands took longer than specified as hardLimit.
Attached is the recorded log where you can check which command exceeded the execution time.

If it happens again, then I will stop the execution of the commands, because this is a sign that there is a bug in Mautic.

Success!
Script $(readlink -f "$0")

PS: Date and time of verification: $(date +'%Y-%m-%d %H:%M:%S')
EOL
)
  fi
  sendemail -f $FROM_EMAIL -s $FROM_SERVER_PORT -xu $FROM_USER -xp ''$FROM_PASS'' -t $ADMIN_EMAIL -m "$content" -a $log_file -u "$subject" -o message-charset=utf-8 > /dev/null 2>&1
  rm $log_file
fi
