#!/bin/bash

# Run native
CUDA_VISIBLE_DEVICES=$1 \
bash paddle/run_and_time.sh &> "$(hostname).${2}.GPU${1}.${3}.native.log"

