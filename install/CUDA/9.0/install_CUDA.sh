#!/bin/bash
bash cuda_9.0.176_384.81_linux-run --silent \
  --override \
  --toolkit --toolkitpath=${HOME}/opt/cuda/9.0 \
  --samples --samplespath=${HOME}/opt/cuda/9.0/samples
#Install patches
bash cuda_9.0.176.1_linux-run --silent --accept-eula --installdir=${HOME}/opt/cuda/9.0
bash cuda_9.0.176.2_linux-run --silent --accept-eula --installdir=${HOME}/opt/cuda/9.0
bash cuda_9.0.176.3_linux-run --silent --accept-eula --installdir=${HOME}/opt/cuda/9.0
bash cuda_9.0.176.4_linux-run --silent --accept-eula --installdir=${HOME}/opt/cuda/9.0

