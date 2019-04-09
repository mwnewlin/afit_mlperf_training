#!/bin/bash
BENCHMARKS=( sentiment_analysis
        rnn_translator
        recommendation
        translation object_detection )


for BENCHMARK in "${BENCHMARKS[@]}"
do
        mkdir -p ${BENCHMARK}/results

	# mustang compute node (Type 1)
        OUT_FILE="${BENCHMARK}/results/type1-mustang.native.csv"
        grep RESULT ${BENCHMARK}/${BENCHMARK}_native.o????? 2>/dev/null | cut -d',' -f4 > ${OUT_FILE}
        git add -f ${OUT_FILE}

        OUT_FILE="${BENCHMARK}/results/type1-mustang.singularity.csv"
        grep RESULT ${BENCHMARK}/${BENCHMARK}_singularity.o????? 2>/dev/null | cut -d',' -f4 > ${OUT_FILE}
        git add -f ${OUT_FILE}

	# mustang interactive (Type 1a)
        OUT_FILE="${BENCHMARK}/results/type1a-mustang.native.csv"
        grep RESULT ${BENCHMARK}/mustang*.native.log 2>/dev/null | cut -d',' -f4 > ${OUT_FILE}
        git add -f ${OUT_FILE}

        OUT_FILE="${BENCHMARK}/results/type1a-mustang.singularity.csv"
        grep RESULT ${BENCHMARK}/mustang*.singularity.log 2>/dev/null | cut -d',' -f4 > ${OUT_FILE}
        git add -f ${OUT_FILE}

        git commit -m"Updating mustang results for ${BENCHMARK}."

done

