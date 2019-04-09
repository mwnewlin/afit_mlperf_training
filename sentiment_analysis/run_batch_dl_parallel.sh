#!/bin/bash
# Default batch size is 100 or $1
BATCH_SIZE=100
BATCH_SIZE=${1:-${BATCH_SIZE}}

cd ${HOME}/git/afit_mlperf_training/sentiment_analysis

# Be sure to
#   conda activate paddlepaddle-gpu
# before running
if [ "$CONDA_DEFAULT_ENV" != "paddlepaddle-gpu" ]
then
	echo "Error: not in the correct conda environment."
	echo "  Be sure to run 'conda activate paddlepaddle-gpu'"
	echo "  before running this script."
	exit 1
fi

# Count the number of NVIDIA GPUs
NUM_GPUS=$(find /proc/driver/nvidia/gpus/ -mindepth 1 -maxdepth 1 -type d | wc -l)
if [ ${NUM_GPUS} -eq 0 ] ; then
		echo "Error: No NVIDA GPU found."
		exit 1
fi
echo "Discovered ${NUM_GPUS} NVIDA GPUs"
# Remove offset
NUM_GPUS=$(expr ${NUM_GPUS} - 1)

RUN_START="$(date --date "now" +"%Y-%m-%d-%H-%M")"
for i in $(seq 1 ${BATCH_SIZE})
do
	# Run native
	echo "sentiment_analysis: native, run ${i} of ${BATCH_SIZE}"
	seq 0 ${NUM_GPUS} | parallel "bash run_batch_dl_parallel.native.sh {} ${i}"
	
	# Run singularity
	echo "sentiment_analysis: singularity, run ${i} of ${BATCH_SIZE}"
	seq 0 ${NUM_GPUS} | parallel "bash run_batch_dl_parallel.singularity.sh {} ${i}"
done

