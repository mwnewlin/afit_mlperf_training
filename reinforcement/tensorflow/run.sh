#!/bin/bash
# This script should be only executed in docker.
# Run minigo... stop when it converges.

# Get the directory that this script is ran from
export SOURCE_DIR=${SOURCE_DIR:="$(dirname $(readlink -f "$0"))"}

set -e

SEED=$1
mkdir -p /research/results/minigo/final/
cd /research/reinforcement/minigo
bash loop_main.sh params/final.json $SEED
