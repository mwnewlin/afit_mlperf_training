#Shell script to pull docker image for Sentiment Analysis and run
#sentiment analysis in singularity without interaction
singularity pull --name sentiment_analysis.simg \
				docker://cgret/sentiment_analysis:sa_1.2-gpu-cuda9.0-cudnn7
singularity shell ~/sentiment_analysis.simg	
#Make directory for data	
cd /root/.cache
mkdir paddle
cd paddle
mkdir dataset
cd dataset
mkdir imdb
#Make directory for sentiment analysis files
cd /
mkdir sentiment_analysis
exit
#Change to sentiment_analysis directory
cd ~/Git/afit_mlperf_training/sentiment_analysis
#Run singularity image with GPU and bind directories
singularity shell --nv \
	--bind /mnt/NAS/shared_data/afit_mlperf/training/sentiment_analysis:/root/.cache/paddle/dataset/imdb \
	--bind $(pwd):/sentiment_analysis \
	 ~/sentiment_analysis.simg		
#Change to directory with run script and run with seed 1
cd sentiment_analysis/paddle
./run_and_time.sh 1
