#!/bin/bash
set -e

# runs benchmark and reports time to convergence
# to use the script:
#   run_and_time.sh <random seed 1-5>

THRESHOLD=0.635
BASEDIR=$(dirname -- "$0")

DATA_DIR="${MLPERF_DATA_DIR}/recommendation"

# Set OUTPUT_DIR default to include PBS_JOBID (if it is defined)
#  or a UUID if PBS_JOBID is not defined.
#  This specifies a unique output directory for each run.
OUTPUT_DIR=${2:-"${DATA_DIR}/${PBS_JOBID:-$(uuidgen -t)}"}

PYTHONPATH=${BASEDIR}:${PYTHONPATH}

# start timing
start=$(date +%s)
start_fmt=$(date +%Y-%m-%d\ %r)
echo "STARTING TIMING RUN AT $start_fmt"

# Get command line seed
seed=${1:-1}

echo "unzip ${DATA_DIR}/ml-20m.zip"
if unzip -u ${DATA_DIR}/ml-20m.zip -d ${DATA_DIR}
then
    echo "Start processing ${DATA_DIR}/ml-20m/ratings.csv"
    t0=$(date +%s)
	python ${BASEDIR}/convert.py ${DATA_DIR}/ml-20m/ratings.csv ${OUTPUT_DIR} --negatives 999
    t1=$(date +%s)
	delta=$(( $t1 - $t0 ))
    echo "Finish processing ${DATA_DIR}/ml-20m/ratings.csv in $delta seconds"

    echo "Start training"
    t0=$(date +%s)
	python ${BASEDIR}/ncf.py ${OUTPUT_DIR} -l 0.0005 -b 2048 --layers 256 256 128 64 -f 64 \
		--seed $seed --threshold $THRESHOLD --processes 10
    t1=$(date +%s)
	delta=$(( $t1 - $t0 ))
    echo "Finish training in $delta seconds"

	# end timing
	end=$(date +%s)
	end_fmt=$(date +%Y-%m-%d\ %r)
	echo "ENDING TIMING RUN AT $end_fmt"


	# report result
	result=$(( $end - $start ))
	result_name="recommendation"


	echo "RESULT,$result_name,$seed,$result,$USER,$start_fmt"
else
	echo "Problem unzipping ${DATA_DIR}/ml-20.zip"
	echo "Please run 'download_data.sh && verify_datset.sh' first"
fi
