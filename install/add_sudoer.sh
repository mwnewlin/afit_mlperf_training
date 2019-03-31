#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Error: must be run as root"
  exit 1
fi

if [[ ! ${1} ]]
  then "Error: You must provide a username for an existing user."
  exit 1
fi
  
usermod -aG sudo ${1}

FILE="/etc/sudoers.d/${1}"
echo "${1} ALL=(ALL) NOPASSWD: ALL" > ${FILE}

