#!/bin/bash
BENCHMARKS=( sentiment_analysis
        rnn_translator
        recommendation
        translation object_detection )

for BENCHMARK in "${BENCHMARKS[@]}"
do
        mkdir -p ${BENCHMARK}/results
        
        # onyx compute node (Type 2)
        # These will probably be 0s if the job is killed
        OUT_FILE="${BENCHMARK}/results/type2-onyx.native.csv"
        grep RESULT ${BENCHMARK}/${BENCHMARK}_native.o??????? 2>/dev/null | cut -d',' -f4 > ${OUT_FILE}
        git add -f ${OUT_FILE}

        OUT_FILE="${BENCHMARK}/results/type2-onyx.singularity.csv"
        grep RESULT ${BENCHMARK}/${BENCHMARK}_singularity.o??????? 2>/dev/null | cut -d',' -f4 > ${OUT_FILE}
        git add -f ${OUT_FILE}

        # onyx compute node (Type 2a)
        OUT_FILE="${BENCHMARK}/results/type2a-onyx.native.csv"
        grep RESULT ${BENCHMARK}/nid*.native.log 2>/dev/null | cut -d',' -f4 > ${OUT_FILE}
        git add -f ${OUT_FILE}

        OUT_FILE="${BENCHMARK}/results/type2a-onyx.singularity.csv"
        grep RESULT ${BENCHMARK}/nid*.singularity.log 2>/dev/null | cut -d',' -f4 > ${OUT_FILE}
        git add -f ${OUT_FILE}

done

