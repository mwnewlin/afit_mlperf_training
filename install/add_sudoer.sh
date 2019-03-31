#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Error: must be run as root"
  exit 1
fi

if [[ ! ${1} ]]
  then "Error: You must provide a username for an existing user."
  exit 1
fi

# use sudo or wheel
GROUP=$(getent group sudo | cut -d':' -f1)
GROUP=${GROUP:-$(getent group wheel | cut -d':' -f1)}
  
usermod -aG ${GROUP} ${1}

FILE="/etc/sudoers.d/${1}"
echo "${1} ALL=(ALL) NOPASSWD: ALL" > ${FILE}

