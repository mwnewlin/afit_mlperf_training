#!/bin/bash



echo "Copying files to bound folder on host"
cp /mlperf/ncf/* /mlperf/experiment/

echo "Running \'run_and_time.sh\'"
bash /mlperf/experiment/run_and_time.sh


echo "End of container holding pattern"
tail -f /dev/null
