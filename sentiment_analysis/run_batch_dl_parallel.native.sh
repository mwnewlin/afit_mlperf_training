#!/bin/bash

# Run native
CUDA_VISIBLE_DEVICES=$1 $2\
bash paddle/run_and_time.sh &> "$(hostname).${RUN_START}.GPU${1}.${2}.native.log"

