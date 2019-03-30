#!/bin/bash
FILE="/etc/sudoers.d/${USER}"
echo "${USER} ALL=(ALL) NOPASSWD: ALL" > ${FILE}

