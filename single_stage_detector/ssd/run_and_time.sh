#!/bin/bash
# runs benchmark and reports time to convergence
# to use the script:
#   run_and_time.sh <random seed> <target threshold>

# Get the directory that this script is ran from
export SOURCE_DIR=${SOURCE_DIR:="$(dirname $(readlink -f "$0"))"}

SEED=${1:-1}
TARGET=${2:-0.212}

time stdbuf -o 0 \
  python3 ${SOURCE_DIR}/train.py --seed $SEED --threshold $TARGET | tee run.log.$SEED
