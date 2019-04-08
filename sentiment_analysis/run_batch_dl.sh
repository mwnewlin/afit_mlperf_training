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

RUN_START="$(date --date "now" +"%Y-%m-%d-%H-%M")"
for i in $(seq 1 ${BATCH_SIZE})
do
	# Run native
	echo "sentiment_analysis: native, run ${i} of ${BATCH_SIZE}"
	bash paddle/run_and_time.sh &> "$(hostname).${RUN_START}.${i}.native.log"

	# Run singularity
	# Note: need sudo on DL/ML boxes due to permission configuration on NAS.
	echo "sentiment_analysis: singularity, run ${i} of ${BATCH_SIZE}"
	sudo MLPERF_DATA_DIR="/mnt/NAS/shared_data/afit_mlperf/training" singularity exec \
		--nv \
		--bind $(pwd):/benchmark \
		--bind ${MLPERF_DATA_DIR}:/data \
		${SINGULARITY_CONTAINER_PATH}/sentiment_analysis.simg \
		/bin/bash  /benchmark/paddle/run_and_time.sh &> "$(hostname).${RUN_START}.${i}.singularity.log"
done

