#!/bin/bash

# $1 is the GPU (integer)
# $2 is the RUN_DATE
# $3 is the batch number

# Run native
CUDA_VISIBLE_DEVICES=$1 \
bash paddle/run_and_time.sh &> "$(hostname).${2}.GPU${1}.${3}.native.log"

