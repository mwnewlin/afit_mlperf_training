#!/bin/bash
cd ${HOME}/git/afit_mlperf_training/sentiment_analysis

# Be sure to
#  conda activate paddlepaddle-gpu
# before running

for i in {1..100}
do
	# Run native
	echo "sentiment_analysis: native, run ${i}"
	bash paddle/run_and_time.sh &> "$(hostname).$(date --date "now" +"%Y-%m-%d-%H-%M").native.log"

	# Run singularity
	# Note: need sudo on DL/ML boxes due to permission configuration on NAS.
	echo "sentiment_analysis: singularity, run ${i}"
	singularity exec \
		--nv \
		--bind $(pwd):/benchmark \
		--bind ${MLPERF_DATA_DIR}:/data \
		${SINGULARITY_CONTAINER_PATH}/sentiment_analysis.simg \
		/bin/bash  /benchmark/paddle/run_and_time.sh &> "$(hostname).$(date --date "now" +"%Y-%m-%d-%H-%M").singularity.log"
done

