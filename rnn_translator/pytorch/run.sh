#!/bin/bash

set -e

# Get the directory that this script is ran from
export SOURCE_DIR=${SOURCE_DIR:="$(dirname $(readlink -f "$0"))"}

DATASET_DIR="${MLPERF_DATA_DIR}/rnn_translator"
# FIXME: need to write the results to a seperate
#        directory for each run.  In PBS this could
#        be based on ${JOBDIR} or ${PBS_JOBID}
#    I'm using PBS_JOBID or uuidgen -t if PBS_JOBID is not defined.
RESULTS_DIR="${MLPERF_DATA_DIR}/rnn_translator/results/${PBS_JOBID:-$($(which uuidgen))}"


SEED=${1:-"1"}
TARGET=${2:-"21.80"}

# Add source directory to pick up 'multiproc' module
export PYTHONPATH=${SOURCE_DIR}:${PYTHONPATH}

# run training
python3 -m multiproc ${SOURCE_DIR}/train.py \
  --results-dir ${RESULTS_DIR} \
  --save gnmt_wmt16 \
  --dataset-dir ${DATASET_DIR} \
  --seed ${SEED} \
  --target-bleu ${TARGET} \
  --epochs 8 \
  --batch-size 128 \
  --math fp16

