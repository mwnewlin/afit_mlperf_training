#!/bin/bash
cd ${HOME}/git/afit_mlperf_training/rnn_translator

conda activate pytorch-gpu

for in in {1..100}
do
	# Run native
	bash pytorch/run_and_time.sh &> "$(hostname).$(date --date "now" +"%Y-%m-%d-%H-%M").native.log"

	# Run singularity
	# Note: need sudo on DL/ML boxes due to permission configuration on NAS.
	sudo singularity exec \
		--nv \
		--bind $(pwd):/benchmark \
		--bind ${MLPERF_DATA_DIR}:/data \
		${SINGULARITY_CONTAINER_PATH}/rnn_translator.simg \
		/bin/bash  /benchmark/pytorch/run_and_time.sh &> "$(hostname).$(date --date "now" +"%Y-%m-%d-%H-%M").singularity.log"
done

