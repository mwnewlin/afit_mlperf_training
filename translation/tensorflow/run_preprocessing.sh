#!/bin/bash

set -e

# Get the directory that this script is ran from
SOURCE_DIR=${SOURCE_DIR:="$(dirname $(readlink -f "$0"))"}

SEED=$1

#cd /research/transformer

# TODO: Add SEED to process_data.py since this uses a random generator (future PR)
export PYTHONPATH=${SOURCE_DIR}/transformer:${PYTHONPATH}
# Add compliance to PYTHONPATH
# export PYTHONPATH=/mlperf/training/compliance:${PYTHONPATH}

python3 ${SOURCE_DIR}/process_data.py \
  --raw_dir ${MLPERF_DATA_DIR}/translation/raw_data/ \
  --data_dir ${MLPERF_DATA_DIR}/translation/processed_data
