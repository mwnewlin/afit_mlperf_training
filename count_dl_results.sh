#!/bin/bash
BENCHMARKS=( sentiment_analysis 
	rnn_translator
	recommendation
	translation object_detection )

SERVERS=( dlserver
	nvidia_box
	ovechkin )
	
for BENCHMARK in "${BENCHMARKS[@]}"
do
	for SERVER in "${SERVERS[@]}"
	do
		NATIVE_COUNT=$(grep RESULT ${BENCHMARK}/${SERVER}.*.native.log 2>/dev/null | wc -l )
		SINGULARITY_COUNT=$(grep RESULT ${BENCHMARK}/${SERVER}.*.singularity.log 2>/dev/null | wc -l )
		echo "${BENCHMARK}: ${SERVER}: ${NATIVE_COUNT}, ${SINGULARITY_COUNT}"
	done
done

