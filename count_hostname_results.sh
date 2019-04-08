#!/bin/bash
BENCHMARKS=( sentiment_analysis 
	rnn_translator
	recommendation
	translation object_detection )

for BENCHMARK in "${BENCHMARKS[@]}"
do
	NATIVE_COUNT=$(grep RESULT ${BENCHMARK}/$(hostname).*.native.log 2>/dev/null | wc -l )
	SINGULARITY_COUNT=$(grep RESULT ${BENCHMARK}/$(hostname).*.singularity.log 2>/dev/null | wc -l )
	echo "${BENCHMARK}: ${SERVER}: ${NATIVE_COUNT}, ${SINGULARITY_COUNT}"
done


