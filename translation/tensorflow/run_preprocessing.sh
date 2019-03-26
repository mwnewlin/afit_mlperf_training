#!/bin/bash

set -e

if [[ $# -ne 2 ]] ; then
    echo 'ERROR: Script requires a SEED and DATA_DIR argument.'
    exit 1
fi

SEED=$1
DATA_DIR=$2

# Get the directory that this script is ran from
SOURCE_DIR=${SOURCE_DIR:="$(dirname $(readlink -f "$0"))"}

# TODO: Add SEED to process_data.py since this uses a random generator (future PR)
export PYTHONPATH=${SOURCE_DIR}/transformer:${PYTHONPATH}
# Add compliance to PYTHONPATH
# export PYTHONPATH=/mlperf/training/compliance:${PYTHONPATH}


python3 ${SOURCE_DIR}/process_data.py \
  --raw_dir ${MLPERF_DATA_DIR}/translation/raw_data/ \
  --data_dir ${DATA_DIR}
