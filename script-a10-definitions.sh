#!/bin/bash

###############################################################################
#                                                                             #
# Define colors as names                                                      #
#                                                                             #
###############################################################################

echo "[$(date +%Y-%m-%d_%H:%M:%S)]  InstallScript  🛈  Loading definitions ..."

RCol='\e[0m'    # Text Reset

# Regular           Bold                Underline           High Intensity      BoldHigh Intens     Background          High Intensity Backgrounds
Bla='\e[0;30m';     BBla='\e[1;30m';    UBla='\e[4;30m';    IBla='\e[0;90m';    BIBla='\e[1;90m';   On_Bla='\e[40m';    On_IBla='\e[0;100m';
Red='\e[0;31m';     BRed='\e[1;31m';    URed='\e[4;31m';    IRed='\e[0;91m';    BIRed='\e[1;91m';   On_Red='\e[41m';    On_IRed='\e[0;101m';
Gre='\e[0;32m';     BGre='\e[1;32m';    UGre='\e[4;32m';    IGre='\e[0;92m';    BIGre='\e[1;92m';   On_Gre='\e[42m';    On_IGre='\e[0;102m';
Yel='\e[0;33m';     BYel='\e[1;33m';    UYel='\e[4;33m';    IYel='\e[0;93m';    BIYel='\e[1;93m';   On_Yel='\e[43m';    On_IYel='\e[0;103m';
Blu='\e[0;34m';     BBlu='\e[1;34m';    UBlu='\e[4;34m';    IBlu='\e[0;94m';    BIBlu='\e[1;94m';   On_Blu='\e[44m';    On_IBlu='\e[0;104m';
Pur='\e[0;35m';     BPur='\e[1;35m';    UPur='\e[4;35m';    IPur='\e[0;95m';    BIPur='\e[1;95m';   On_Pur='\e[45m';    On_IPur='\e[0;105m';
Cya='\e[0;36m';     BCya='\e[1;36m';    UCya='\e[4;36m';    ICya='\e[0;96m';    BICya='\e[1;96m';   On_Cya='\e[46m';    On_ICya='\e[0;106m';
Whi='\e[0;37m';     BWhi='\e[1;37m';    UWhi='\e[4;37m';    IWhi='\e[0;97m';    BIWhi='\e[1;97m';   On_Whi='\e[47m';    On_IWhi='\e[0;107m';


###############################################################################
#                                                                             #
# Define usefull functions                                                    #
#                                                                             #
###############################################################################

execution_count=0

function show_info() {
  local state="$1"
  local comment="$2"
  local seconds="$3"

  if [[ "$seconds" =~ ^[1-9]$ ]]; then
    execution_count=$((execution_count + 1))
    echo -e "\n${BCya}[$(date +%Y-%m-%d_%H:%M:%S)]  InstallScript  ${state}  ${comment}"
    echo -e "[$(date +%Y-%m-%d_%H:%M:%S)]  InstallScript  ⌛  (${execution_count}) We continue after ${seconds} second$([[ $wait != 1 ]] && echo "s") ..."
    echo -e "${RCol}"

    line=$(printf '%.0s.' {1..100})
    printf "%s\r" "${line}"
    for ((i=1; i<=100; i++)); do
      line="${line:0:i-1}=${line:i}"
      printf "%s\r" "${line}"
      sleep "0.0${seconds}"
    done

    echo -e "\n"
  else
    echo "${BCya}[$(date +%Y-%m-%d_%H:%M:%S)]  InstallScript  ${state}  ${comment}${RCol}"
  fi
}

show_debug() {
	execution_count=$((execution_count + 1))
	echo ; echo ; echo -e "${BCya}${execution_count}. $1 : ⌛ We continue after 1 second ..."; echo -e "${RCol}"; echo ; sleep 1
}


function answer_yes_else_stop() {
  show_info ❓ "$1"
  read -p 'Answer: ' answer
  if ! check_positive "${answer}"; then
    exit 1
  fi
  return 0
}

function check_positive() {
  local answer="$1"
  if [[ "${answer,,}" == 'da' || "${answer,,}" == 'yes' || "${answer,,}" == 'y' || "${answer,,}" == '1' ]]; then
    return 0
  fi
  return 1
}

show_info ✅ 'Definitions loaded !'
