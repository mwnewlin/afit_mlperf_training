#!/bin/bash
# Default batch size is 5 or $1
BATCH_SIZE=5
BATCH_SIZE=${1:-${BATCH_SIZE}}

cd ${HOME}/git/afit_mlperf_training/translation

echo "loading CUDA 9.0 for Tensorflow 1.9.0"
module unload devel/cuda/9.1
module load devel/cuda/9.0

# Be sure to
#   conda activate tensorflow-1.9.0-gpu
# before running
if [ "$CONDA_DEFAULT_ENV" != "tensorflow-1.9.0-gpu" ]
then
	echo "Error: not in the correct conda environment."
	echo "  Be sure to run 'conda activate tensorflow-1.9.0-gpu'"
	echo "  before running this script."
	exit 1
fi

RUN_START="$(date --date "now" +"%Y-%m-%d-%H-%M")"
for i in $(seq 1 ${BATCH_SIZE})
do
	# Run native
	echo "translation: native, run ${i} of ${BATCH_SIZE}"
	bash tensorflow/run_and_time.sh &> "$(hostname).${RUN_START}.${i}.native.log"

	# Run singularity
	# Note: need sudo on DL/ML boxes due to permission configuration on NAS.
	echo "translation: singularity, run ${i} of ${BATCH_SIZE}"
	sudo MLPERF_DATA_DIR="/mnt/NAS/shared_data/afit_mlperf/training" singularity exec \
		--nv \
		--bind $(pwd):/benchmark \
		--bind ${MLPERF_DATA_DIR}:/data \
		${SINGULARITY_CONTAINER_PATH}/translation.simg \
		/bin/bash  /benchmark/tensorflow/run_and_time.sh &> "$(hostname).${RUN_START}.${i}.singularity.log"
done



