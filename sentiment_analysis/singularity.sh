#!/bin/bash

# See: https://www.sylabs.io/guides/2.6/user-guide/build_a_container.html

# On mustang "Configuration disallows users from running directory based containers"
#singularity build \
#  --sandbox \
#  ${SINGULARITY_CONTAINER_PATH}/sentiment_analysis.simg \
#  docker://cgret/sentiment_analysis:sa_1.2-gpu-cuda9.0-cudnn7

# On mustang "Writable images must be created as root"
#singularity build \
#  --writable \
#  ${SINGULARITY_CONTAINER_PATH}/sentiment_analysis.simg \
#  docker://cgret/sentiment_analysis:sa_1.2-gpu-cuda9.0-cudnn7


