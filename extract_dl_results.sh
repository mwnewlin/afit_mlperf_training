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
	mkdir -p ${BENCHMARK}/results
	for SERVER in "${SERVERS[@]}"
	do
		OUT_FILE="${BENCHMARK}/results/${SERVER}.native.csv"
		grep RESULT ${BENCHMARK}/${SERVER}.*.native.log 2>/dev/null |  cut -d',' -f4 > ${OUT_FILE}
		git add -f ${OUT_FILE}

                OUT_FILE="${BENCHMARK}/results/${SERVER}.singularity.csv"
                grep RESULT ${BENCHMARK}/${SERVER}.*.singularity.log 2>/dev/null |  cut -d',' -f4 > ${OUT_FILE}
                git add -f ${OUT_FILE}

	done
	git commit -m"Updating DL results for ${BENCHMARK}."
done


