#!/bin/bash
BENCHMARKS=( sentiment_analysis
        rnn_translator
        recommendation
        translation object_detection )


HOST=$(hostname)

for BENCHMARK in "${BENCHMARKS[@]}"
do
        mkdir -p ${BENCHMARK}/results

	# interactive
        OUT_FILE="${BENCHMARK}/results/${HOST}.native.csv"
        grep RESULT ${BENCHMARK}/${HOST}*.native.log 2>/dev/null | cut -d',' -f4 > ${OUT_FILE}
        git add -f ${OUT_FILE}

        OUT_FILE="${BENCHMARK}/results/${HOST}.singularity.csv"
        grep RESULT ${BENCHMARK}/${HOST}*.singularity.log 2>/dev/null | cut -d',' -f4 > ${OUT_FILE}
        git add -f ${OUT_FILE}

        git commit -m"Updating ${HOST} results for ${BENCHMARK}."

done

