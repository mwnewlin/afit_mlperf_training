#/bin/bash

# This script runs preprocessing on the downloaded data
# and times (exlcusively) training to the target accuracy.

# Get the directory that this script is ran from
export SOURCE_DIR=${SOURCE_DIR:="$(dirname $(readlink -f "$0"))"}

# To use the script:
# run_and_time.sh <random seed 1-5>

TARGET_UNCASED_BLEU_SCORE=20

set -e

export COMPLIANCE_FILE="/tmp/transformer_compliance_${SEED}.log"
# path to the mlpef_compliance package in local directory,
# if not set then default to the package name for installing from PyPI.
export MLPERF_COMPLIANCE_PKG=${MLPERF_COMPLIANCE_PKG:-mlperf_compliance}

# Install mlperf_compliance package.
# The mlperf_compliance package is used for compliance logging.
# MED: this doesn't work in the Singularity image as configured
#      It works OK in the native run with a user conda environment.
#pip install ${MLPERF_COMPLIANCE_PKG}

# Set SEED default to 1
SEED=${1:-1}

# Set DATA_DIR default to include PBS_JOBID (if it is defined)
#  or a UUID if PBS_JOBID is not defined.
#  This specifies a unique data directory for each run.
DATA_DIR=${2:-"${MLPERF_DATA_DIR}/translation/processed_data/${PBS_JOBID:-$(uuidgen -t)}"}

# Run preprocessing (not timed)
# TODO: Seed not currently used but will be in a future PR
. ${SOURCE_DIR}/run_preprocessing.sh ${SEED} ${DATA_DIR}

# Start timing
START=$(date +%s)
START_FMT=$(date +%Y-%m-%d\ %r)
echo "STARTING TIMING RUN AT ${START_FMT}"


echo "Running benchmark with seed ${SEED}"
. ${SOURCE_DIR}/run_training.sh ${SEED} ${TARGET_UNCASED_BLEU_SCORE} ${DATA_DIR}

RET_CODE=$?; if [[ ${RET_CODE} != 0 ]]; then exit ${RET_CODE}; fi

# End timing
END=$(date +%s)
END_FMT=$(date +%Y-%m-%d\ %r)

echo "ENDING TIMING RUN AT ${END_FMT}"

# Report result
RESULT=$(( ${END} - ${START} ))
RESULT_NAME="transformer"

echo "RESULT,${RESULT_NAME},${SEED},${RESULT},${USER},${START_FMT}"
