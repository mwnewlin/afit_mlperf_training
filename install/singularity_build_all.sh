#!/bin/bash
SOURCE_DIR=${SOURCE_DIR:="$(dirname $(readlink -f "$0"))"}
if [ -f "${SOURCE_DIR}/singularity_build.sh" ]
then
	echo "Building Singularity.* from ${HOME}/git/afit_mlperf_training."
	sudo \
		find ${HOME}/git/afit_mlperf_training \
			-name Singularity.* \
			-type f 
			-exec ${SOURCE_DIR}/singularity_build.sh {} \;
else
	echo "Error: singularity_build.sh not in ${SOURCE_DIR}"
fi

