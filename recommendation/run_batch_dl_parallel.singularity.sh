#!/bin/bash

# $1 is the GPU (integer)
# $2 is the RUN_DATE
# $3 is the batch number

# Run singularity
# Note: need sudo on DL/ML boxes due to permission configuration on NAS.

sudo \
CUDA_VISIBLE_DEVICES="$1" \
MLPERF_DATA_DIR="/mnt/NAS/shared_data/afit_mlperf/training" \
singularity exec \
	--nv \
	--bind "$(pwd)":/benchmark \
	--bind "${MLPERF_DATA_DIR}":/data \
	"${SINGULARITY_CONTAINER_PATH}"/recommendation.simg \
	/bin/bash  /benchmark/paddle/run_and_time.sh &> "$(hostname).${2}.GPU${1}.${3}.singularity.log"
