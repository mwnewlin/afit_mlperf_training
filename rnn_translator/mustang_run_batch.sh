#!/bin/bash

# Default batch size is 5 or $1
BATCH_SIZE=5
BATCH_SIZE=${1:-${BATCH_SIZE}}

cd ${HOME}/git/afit_mlperf_training/rnn_translator

if [ "$CONDA_DEFAULT_ENV" != "pytorch-gpu" ]
then
	echo "Error: not in the correct conda environment."
	echo "  Be sure to run 'conda activate pytorch-gpu'"
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

	# Run singularity
	echo "rnn_translator: singularity, run ${i} of ${BATCH_SIZE}"
	singularity exec \
		--nv \
		--bind $(pwd):/benchmark \
		--bind ${MLPERF_DATA_DIR}:/data \
		${SINGULARITY_CONTAINER_PATH}/rnn_translator.simg \
		/bin/bash  /benchmark/pytorch/run_and_time.sh &> "$(hostname).${RUN_START}.${i}.singularity.log"

        # Run native
        echo "rnn_translator: native, run ${i} of ${BATCH_SIZE}"
        bash pytorch/run_and_time.sh &> "$(hostname).${RUN_START}.${i}.native.log"


done

grep -Hn $(hostname).*.native.log > "$(hostname).${RUN_START}.native.results.log"
grep -Hn $(hostname).*.singularity.log > "$(hostname).${RUN_START}.singularity.results.log"

