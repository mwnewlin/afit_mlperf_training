DATA_DIR="${MLPERF_DATA_DIR}/recommendation"
mkdir -p ${DATA_DIR}

function download_20m {
	echo "Download ml-20m"
	wget -nc http://files.grouplens.org/datasets/movielens/ml-20m.zip \
	  -O ${DATA_DIR}/ml-20m.zip
}

function download_1m {
	echo "Downloading ml-1m"
	wget -nc http://files.grouplens.org/datasets/movielens/ml-1m.zip \
	  -O ${DATA_DIR}/ml-1m.zip
}

if [[ $1 == "ml-1m" ]]
then
	download_1m
else
	download_20m
fi
