#!/bin/bash
BENCHMARKS=( sentiment_analysis
        rnn_translator
        recommendation
        translation object_detection )

for BENCHMARK in "${BENCHMARKS[@]}"
do
        # onyx compute node (Type 2)
        NATIVE_COUNT=$(grep RESULT ${BENCHMARK}/${BENCHMARK}_native.o??????? 2>/dev/null | wc -l )
        SINGULARITY_COUNT=$(grep RESULT ${BENCHMARK}/${BENCHMARK}_singularity.o??????? 2>/dev/null | wc -l )
        echo "${BENCHMARK}: Type 2  : ${NATIVE_COUNT}, ${SINGULARITY_COUNT}"

        # onyx compute node (Type 2a)
        #  This will probably be a duplicate of the Type 2 count
        NATIVE_COUNT=$(grep RESULT ${BENCHMARK}/nid*.native.log 2>/dev/null | wc -l )
        SINGULARITY_COUNT=$(grep RESULT ${BENCHMARK}/nid*.singularity.log 2>/dev/null | wc -l )
        echo "${BENCHMARK}: Type 2a : ${NATIVE_COUNT}, ${SINGULARITY_COUNT}"


        # onyx interactive (Type 2b)
	#  These should all be 0 because onyx
	#  doesn't have GPUs on the login nodes
        NATIVE_COUNT=$(grep RESULT ${BENCHMARK}/onyx*.native.log 2>/dev/null | wc -l )
        SINGULARITY_COUNT=$(grep RESULT ${BENCHMARK}/onyx*.singularity.log 2>/dev/null | wc -l )
        echo "${BENCHMARK}: Type 2b : ${NATIVE_COUNT}, ${SINGULARITY_COUNT}"

done

