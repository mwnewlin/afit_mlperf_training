#!/bin/bash
cd ${HOME}/git/afit_mlperf_training/translation

module unload devel/cuda/9.1
module load devel/cuda/9.0

# Be sure to
#   conda activate tensorflow-gpu
# before running
if [ "$CONDA_DEFAULT_ENV" != "tensorflow-gpu" ]
then
	echo "Error: not in the correct conda environment."
	echo "  Be sure to run 'conda activate tensorflow-gpu'"
	echo "  before running this script."
	exit 1
fi

for i in {1..100}
do
	# Run native
	echo "translation: native, run ${i}"
	bash tensorflow/run_and_time.sh &> "$(hostname).$(date --date "now" +"%Y-%m-%d-%H-%M").native.log"

	# Run singularity
	# Note: need sudo on DL/ML boxes due to permission configuration on NAS.
	echo "translation: singularity, run ${i}"
	sudo MLPERF_DATA_DIR="/mnt/NAS/shared_data/afit_mlperf/training"  singularity exec \
		--nv \
		--bind $(pwd):/benchmark \
		--bind ${MLPERF_DATA_DIR}:/data \
		${SINGULARITY_CONTAINER_PATH}/translation.simg \
		/bin/bash  /benchmark/tensorflow/run_and_time.sh &> "$(hostname).$(date --date "now" +"%Y-%m-%d-%H-%M").singularity.log"
done



