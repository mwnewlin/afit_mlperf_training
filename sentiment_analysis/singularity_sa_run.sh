#!bin/bash
#Shell script to build singularity image from docker image for Sentiment Analysis and run
#sentiment analysis in singularity without interaction
singularity build ${SINGULARITY_CONTAINER_PATH}/sentiment_analysis.simg docker://cgret/sentiment_analysis:sa_1.2-gpu-cuda9.0-cudnn7
#Make directory for data
cd ~/Git/afit_mlperf_training/sentiment_analysis
singularity shell ${SINGULARITY_CONTAINER_PATH}/sentiment_analysis.simg	-c \
    "cd /root/.cache && mkdir paddle && mkdir paddle/dataset && mkdir paddle/dataset/imdb && exit"
#Change to sentiment_analysis directory
cd ~/Git/afit_mlperf_training/sentiment_analysis
#Run singularity image with GPU (--nv) and bind directories
singularity shell --nv \
	--bind ${MLPERF_DATA_DIR}/sentiment_analysis:/root/.cache/paddle/dataset/imdb \
	--bind $(pwd):/sentiment_analysis \
	 ${SINGULARITY_CONTAINER_PATH}/sentiment_analysis.simg \
      -c "cd /sentiment_analysis/paddle && ./run_and_time.sh 1"		

