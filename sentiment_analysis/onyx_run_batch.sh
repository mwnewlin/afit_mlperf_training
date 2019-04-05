#!/bin/bash

# Default batch size is 5 or $1
BATCH_SIZE=5
BATCH_SIZE=${1:-${BATCH_SIZE}}

cd ${HOME}/git/afit_mlperf_training/sentiment_analysis

source ${MODULESHOME}/init/bash

# conda init bash
source ${HOME}/.bashrc

conda activate paddlepaddle-gpu

if [ "$CONDA_DEFAULT_ENV" != "paddlepaddle-gpu" ]
then
	echo "Error: not in the correct conda environment."
	echo "  Be sure to run 'conda activate paddlepaddle-gpu'"
	echo "  before running this script."
	exit 1
fi

RUN_START="$(date --date "now" +"%Y-%m-%d-%H-%M")"

echo "---------------------------------------"
nvidia-smi
nvidia-smi topo -m
free -g
env | sort
ls -la
if [ ! -d "${TMPDIR}" ]; then
	echo "create ${TMPDIR}"
	mkdir -p ${TMPDIR}
fi
echo "---------------------------------------"

for i in $(seq 1 ${BATCH_SIZE})
do
	# Run native
	echo "sentiment_analysis: native, run ${i} of ${BATCH_SIZE}"
	bash paddle/run_and_time.sh &> "$(hostname).${RUN_START}.native.log"

	# Run singularity
	echo "sentiment_analysis: singularity, run ${i} of ${BATCH_SIZE}"
	singularity exec \
		--nv \
		--bind $(pwd):/benchmark \
		--bind ${MLPERF_DATA_DIR}:/data \
		${SINGULARITY_CONTAINER_PATH}/sentiment_analysis.simg \
		/bin/bash  /benchmark/paddle/run_and_time.sh &> "$(hostname).${RUN_START}.singularity.log"
done

grep -Hn $(hostname).*.native.log > "$(hostname).${RUN_START}.native.results.log"
grep -Hn $(hostname).*.singularity.log > "$(hostname).${RUN_START}.singularity.results.log"

