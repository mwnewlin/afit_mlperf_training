#!/bin/bash
cd ${HOME}/git/afit_mlperf_training/sentiment_analysis

conda activate paddlepaddle-gpu

for in in {1..100}
do
	# Run native
	bash paddle/run_and_time.sh &> "$(hostname).$(date --date "now" +"%Y-%m-%d-%H-%M").native.log"

	# Run singularity
	singularity exec \
		--nv \
		--bind $(pwd):/benchmark \
		--bind ${MLPERF_DATA_DIR}:/data \
		${SINGULARITY_CONTAINER_PATH}/sentiment_analysis.simg \
		/bin/bash  /benchmark/paddle/run_and_time.sh &> "$(hostname).$(date --date "now" +"%Y-%m-%d-%H-%M").singularity.log"
done

