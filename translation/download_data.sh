#!/bin/bash

cd tensorflow
wget https://raw.githubusercontent.com/tensorflow/models/master/official/transformer/test_data/newstest2014.en -O newstest2014.en
wget https://raw.githubusercontent.com/tensorflow/models/master/official/transformer/test_data/newstest2014.de -O newstest2014.de

python3 data_download.py --raw_dir raw_data
