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
        # These will probably be 0s if the job is killed
        NATIVE_COUNT=$(grep RESULT ${BENCHMARK}/nid*.native.log 2>/dev/null | wc -l )
        SINGULARITY_COUNT=$(grep RESULT ${BENCHMARK}/nid*.singularity.log 2>/dev/null | wc -l )
        echo "${BENCHMARK}: Type 2a : ${NATIVE_COUNT}, ${SINGULARITY_COUNT}"


done

