#!/bin/bash

# clean the tqdm progress bar
# from log files
mv --verbose "$1" "$1".tmp
grep -v 'it/s]' "$1".tmp | grep -v warnings.warn | grep -v deprecated > "$1"
rm --verbose "$1".tmp

