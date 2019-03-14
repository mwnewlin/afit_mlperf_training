#!/bin/bash



cd /raw_data
bash download_data.sh

bash /translation/tensorflow/run_and_time.sh







cd translation/tensorflow
IMAGE=`sudo docker build . | tail -n 1 | awk '{print $3}'`
SEED=1
NOW=`date "+%F-%T"`
sudo docker run \
    --runtime=nvidia \
    -v $(pwd)/translation/raw_data:/raw_data \
    -v $(pwd)/compliance:/mlperf/training/compliance \
    -e "MLPERF_COMPLIANCE_PKG=/mlperf/training/compliance" \
    -t -i $IMAGE "./run_and_time.sh" $SEED | tee benchmark-$NOW.log
