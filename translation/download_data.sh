#!/bin/bash


wget https://raw.githubusercontent.com/tensorflow/models/master/official/transformer/test_data/newstest2014.en \
  -O ${MLPERF_DATA_DIR}/translation/newstest2014.en
wget https://raw.githubusercontent.com/tensorflow/models/master/official/transformer/test_data/newstest2014.de \
  -O ${MLPERF_DATA_DIR}/translation/newstest2014.de

python3 data_download.py --raw_dir ${MLPERF_DATA_DIR}/translation/raw_data
