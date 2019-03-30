#!/bin/bash
sudo find ${HOME}/git/afit_mlperf_training -name Singularity.* -type f -exec ./singularity_build.sh {} \;

