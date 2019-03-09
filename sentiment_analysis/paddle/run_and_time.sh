#!/bin/bash

# Get the directory that this script is ran from
export SOURCE_DIR=${SOURCE_DIR:="$(dirname $(readlink -f "$0"))"}

# Start timing
start_time=$(date +%s)
start_fmt=$(date +%Y-%m-%d\ %r)
echo "STARTING TIMING RUN AT $start_fmt"

SEED=$1
echo "Running sentiment benchmark with seed ${SEED}"

# Train a sentiment_analysis model (default: conv model), with a user
# specified seed
python ${SOURCE_DIR}/train.py -s ${SEED}

# End timing
end_time=$(date +%s)
end_fmt=$(date +%Y-%m-%d\ %r)
echo "ENDING TIMING RUN AT $end_fmt"

# Report result
result=$(( ${end_time} - ${start_time} ))
result_name="sentiment"

echo "RESULT,$result_name,$seed,$result,$USER,$start_fmt"
