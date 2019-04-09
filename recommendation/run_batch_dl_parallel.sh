#!/bin/bash
# Default batch size is 5 or $1
BATCH_SIZE=5
BATCH_SIZE=${1:-${BATCH_SIZE}}

cd ${HOME}/git/afit_mlperf_training/recommendation

# Be sure to
#   conda activate pytorch-gpu
# before running
if [ "$CONDA_DEFAULT_ENV" != "pytorch-gpu" ]
then
	echo "Error: not in the correct conda environment."
	echo "  Be sure to run 'conda activate pytorch-gpu'"
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
# GPU numbers start at 0 not 1.
NUM_GPUS=$(expr ${NUM_GPUS} - 1)

RUN_START="$(date --date "now" +"%Y-%m-%d-%H-%M")"
#RUN_START="$(date --date "now" +"%s")"
for i in $(seq 1 ${BATCH_SIZE})
do
	# Run native
	echo "recommendation: native, run ${i} of ${BATCH_SIZE}"
	seq 0 ${NUM_GPUS} | parallel "bash run_batch_dl_parallel.native.sh {} ${RUN_START} ${i}"
	
	# Run singularity
	echo "recommendation: singularity, run ${i} of ${BATCH_SIZE}"
	seq 0 ${NUM_GPUS} | parallel "bash run_batch_dl_parallel.singularity.sh {} ${RUN_START} ${i}"
done

