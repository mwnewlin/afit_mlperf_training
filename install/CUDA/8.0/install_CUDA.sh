#!/bin/bash
bash cuda_8.0.61_375.26_linux-run --silent \
  --override \
  --toolkit --toolkitpath=${HOME}/opt/cuda/8.0 \
  --samples --samplespath=${HOME}/opt/cuda/8.0/samples
#Install patches
bash cuda_8.0.61.2_linux-run --silent --accept-eula --installdir=${HOME}/opt/cuda/8.0

