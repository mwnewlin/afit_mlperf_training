#!/bin/bash

DATA_DIR="${MLPERF_DATA_DIR}/translation"
mkdir -p ${DATA_DIR}

wget https://raw.githubusercontent.com/tensorflow/models/master/official/transformer/test_data/newstest2014.en \
  -O ${DATA_DIR}/newstest2014.en
wget https://raw.githubusercontent.com/tensorflow/models/master/official/transformer/test_data/newstest2014.de \
  -O ${DATA_DIR}/newstest2014.de

python3 data_download.py --raw_dir ${DATA_DIR}/raw_data
