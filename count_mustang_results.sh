#!/bin/bash
BENCHMARKS=( sentiment_analysis
        rnn_translator
        recommendation
        translation object_detection )

SERVERS=( mustang
        nvidia_box
        ovechkin )

# mustang*.log is an interactive run
#
for BENCHMARK in "${BENCHMARKS[@]}"
do
	# mustang compute node (Type 1)
        NATIVE_COUNT=$(grep RESULT ${BENCHMARK}/${BENCHMARK}_native.o????? 2>/dev/null | wc -l )
        SINGULARITY_COUNT=$(grep RESULT ${BENCHMARK}/${BENCHMARK}_singularity.o????? 2>/dev/null | wc -l )
        echo "${BENCHMARK}: Type 1  : ${NATIVE_COUNT}, ${SINGULARITY_COUNT}"

	# mustang interactive (Type 1a)
	NATIVE_COUNT=$(grep RESULT ${BENCHMARK}/mustang*.native.log 2>/dev/null | wc -l )
	SINGULARITY_COUNT=$(grep RESULT ${BENCHMARK}/mustang*.singularity.log 2>/dev/null | wc -l )
	echo "${BENCHMARK}: Type 1a : ${NATIVE_COUNT}, ${SINGULARITY_COUNT}"

done

