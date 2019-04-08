#!/bin/bash

# Default batch size is 5 or $1
BATCH_SIZE=5
BATCH_SIZE=${1:-${BATCH_SIZE}}

cd ${HOME}/git/afit_mlperf_training/translation

source ${MODULESHOME}/init/bash

# conda init bash
source ${HOME}/.bashrc

conda activate tensorflow-1.9.0-gpu

if [ "$CONDA_DEFAULT_ENV" != "tensorflow-1.9.0-gpu" ]
then
	echo "Error: not in the correct conda environment."
	echo "  Be sure to run 'conda activate tensorflow-1.9.0-gpu'"
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
	echo "translation: native, run ${i} of ${BATCH_SIZE}"
	bash tensorflow/run_and_time.sh &> "$(hostname).${RUN_START}.${i}.native.log"

	# Run singularity
	echo "translation: singularity, run ${i} of ${BATCH_SIZE}"
	singularity exec \
		--nv \
		--bind $(pwd):/benchmark \
		--bind ${MLPERF_DATA_DIR}:/data \
		${SINGULARITY_CONTAINER_PATH}/translation.simg \
		/bin/bash  /benchmark/tensorflow/run_and_time.sh &> "$(hostname).${RUN_START}.${i}.singularity.log"
done

grep -Hn $(hostname).*.native.log > "$(hostname).${RUN_START}.native.results.log"
grep -Hn $(hostname).*.singularity.log > "$(hostname).${RUN_START}.singularity.results.log"

