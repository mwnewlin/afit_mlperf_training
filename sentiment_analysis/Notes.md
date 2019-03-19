# Docker version

For Docker use a pre-built [paddlepaddle Docker image](https://hub.docker.com/r/paddlepaddle/paddle)

```bash
docker pull paddlepaddle/paddle:1.2-gpu-cuda9.0-cudnn7
```
Command to run the container.
* First --volume mounts the working directory (the sentiment_analysis directory)
* Second --volume mounts the data location as the data location that the program expects (/~/.cache/paddle/dataset/imdb)

Note: We pushed above docker image with our own tag to dockerhub and run that image, hence different image name.


```bash
sudo docker run \
  --volume $(pwd):/sentiment_analysis \
  --volume /mnt/NAS/shared_data/afit_mlperf/training/sentiment_analysis:/root/.cache/paddle/dataset/imdb \
  --interactive \
  --tty \
  cgret/sentiment_analysis:sa_1.2-gpu-cuda9.0-cudnn7 \
  /bin/bash
```

On the DL boxes in your ${HOME}/.bash_login set the MLPERF_DATA_DIRECTORY environment variable:
```bash
export MLPERF_DATA_DIR="/mnt/NAS/shared_data/afit_mlperf/training/"
mkdir -p ${MLPERF_DATA_DIR}
```

```bash
sudo nvidia-docker run \
  --volume $(pwd):/sentiment_analysis \
  --volume ${MLPERF_DATA_DIR}/sentiment_analysis:/root/.cache/paddle/dataset/imdb \
  --interactive \
  --tty \
  cgret/sentiment_analysis:sa_1.2-gpu-cuda9.0-cudnn7 \
  /bin/bash
```

# Data location

This benchmark uses a [dataset](http://www.paddlepaddle.org/documentation/docs/en/develop/api/data/dataset.html) module
to access the IMDB data.  The default location used by the module is '~/.cache/paddle/dataset/imdb' which is set by the
paddlepaddle framework.  Looks like the cache location is not runtime configurable without changing the framework code [dataset/common.py#L37](https://github.com/PaddlePaddle/Paddle/blob/0abfbd1c41e6d558f76252854d4d78bef581b720/python/paddle/dataset/common.py#L37).


# Native version

Create a conda environment for [PaddlePaddle](https://github.com/PaddlePaddle/Paddle) on Mustang
 with:
```bash
conda activate base
conda create --name paddlepaddle-gpu
conda activate paddlepaddle-gpu
conda install pip
pip install paddlepaddle-gpu
```

This assumes that you have loaded a GNU Environment Module for the correct CUDA API version
and cuDNN version.  Check the PBS scripts for examples.


On Onyx (CUDA 8.0, cuDNN 7.1.3):
```bash
conda activate base
conda create --name paddlepaddle-cuda8cudnn7
conda activate paddlepaddle-cuda8cudnn7
conda install pip
pip install paddlepaddle-gpu==1.3.0.post87
```

