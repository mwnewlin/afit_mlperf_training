#!/bin/bash

set -e

# Get the directory that this script is ran from
export SOURCE_DIR=${SOURCE_DIR:="$(dirname $(readlink -f "$0"))"}

DATASET_DIR='${MLPERF_DATA_DIR}/rnn_translator/data'
RESULTS_DIR='${MLPERF_DATA_DIR}/rnn_translator/results/gnmt_wmt16'

SEED=${1:-"1"}
TARGET=${2:-"21.80"}

# Add source directory to pick up 'multiproc' module
export PYTHONPATH=${SOURCE_DIR}:${PYTHONPATH}

# run training
python3 -m multiproc ${SOURCE_DIR}/train.py \
  --save ${RESULTS_DIR} \
  --dataset-dir ${DATASET_DIR} \
  --seed ${SEED} \
  --target-bleu ${TARGET} \
  --epochs 8 \
  --batch-size 128
