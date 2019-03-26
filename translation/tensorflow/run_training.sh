#!/bin/bash

set -e

if [[ $# -ne 3 ]] ; then
    echo 'ERROR: Script requires a SEED, QUALITY and DATA_DIR argument.'
    exit 1
fi

SEED=$1
QUALITY=$2
DATA_DIR=$3

# Get the directory that this script is ran from
export SOURCE_DIR=${SOURCE_DIR:="$(dirname $(readlink -f "$0"))"}


export PYTHONPATH=${SOURCE_DIR}/transformer:${PYTHONPATH}
# Add compliance to PYTHONPATH
# export PYTHONPATH=/mlperf/training/compliance:${PYTHONPATH}

# You might need to switch the model from  'big' to 'base'
# if your GPU starts OOMing
# See: https://github.com/mlperf/training/issues/52

python3 ${SOURCE_DIR}/transformer/transformer_main.py --random_seed=${SEED} \
  --data_dir=${DATA_DIR} \
  --model_dir=${DATA_DIR}/model \
  --params=base \
  --bleu_threshold ${QUALITY} \
  --bleu_source=${MLPERF_DATA_DIR}/translation/newstest2014.en \
  --bleu_ref=${MLPERF_DATA_DIR}/translation/newstest2014.de
