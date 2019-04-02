#!/bin/bash
pushd .

cd ${SINGULARITY_CONTAINER_PATH}

singularity pull \
   --name recommendation.simg  \
   shub://mark-e-deyoung/afit_mlperf_training:recommendation

singularity pull \
   --name rnn_translator.simg  \
   shub://mark-e-deyoung/afit_mlperf_training:rnn_translator

singularity pull \
   --name sentiment_analysis.simg  \
   shub://mark-e-deyoung/afit_mlperf_training:sentiment_analysis

singularity pull \
   --name translation.simg  \
   shub://mark-e-deyoung/afit_mlperf_training:translation


popd
