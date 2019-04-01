# Time to Accuracy
The 'accuracy' for this benchmark is the target quality parameter (--target-quality) for paddle/train.py.  The default value is 90.6.  The benchmark will run for 100 epochs (PASS_NUM=100) or stop when it reaches the target quality.  After several dozen runs on Mustang it looks like the benchmark frequently does not converge with a target quality of 90.6.  It takes about 1 hour 50 minutes to run all 100 epochs with a P100 (16 Gib).

# Data location

This benchmark uses a [dataset](http://www.paddlepaddle.org/documentation/docs/en/develop/api/data/dataset.html) module to access the IMDB data.  The default location used by the module is '~/.cache/paddle/dataset/imdb' which is set by the paddlepaddle framework.  Looks like the cache location is not runtime configurable without changing the framework code (See: [dataset/common.py#L37](https://github.com/PaddlePaddle/Paddle/blob/0abfbd1c41e6d558f76252854d4d78bef581b720/python/paddle/dataset/common.py#L37)).

On the DL boxes in your ${HOME}/.bash_login set the MLPERF_DATA_DIR environment variable:
```bash
export MLPERF_DATA_DIR="/mnt/NAS/shared_data/afit_mlperf/training/"
mkdir -p ${MLPERF_DATA_DIR}
```

In the AFRL DSRC in your ${HOME}/.personal.bashrc set the MLPERF_DATA_DIR environment variable:
```bash
# WORKDIR is defined on both login-nodes and compute-nodes
export MLPERF_DATA_DIR="${WORKDIR}/afit_mlperf_training"
mkdir -p ${MLPERF_DATA_DIR}
```
Your ${HOME} is reachable from each of the clusters in the DSRC.

# Nvidia Docker version
-------------------------------------------
Probably need to create our own paddle image.  The one from dockerhub defines ENV HOME /root
which requires you to run the derived singularity image with sudo.  We won't have sudo in
the HPC environments.

I've added a Dockerfile that I extracted from the dockerhub image to this repo.
I pulled the image and extracted the Dockerfile with:
```bash
sudo docker pull paddlepaddle/paddle:latest-gpu-cuda9.0-cudnn7
docker images
sudo docker pull chenzj/dfimage
alias dfimage="docker run -v /var/run/docker.sock:/var/run/docker.sock --rm chenzj/dfimage"
dfimage e28a3651e077 > Dockerfile
```

Just as a first attempt I used [Singularity Python](https://singularityhub.github.io/singularity-cli/install) to
generate an initial Singularity file.
```bash
pip install spython
spython recipe Dockerfile >> Singularity.snowflake
```
Got the following warnings:
```bash
WARNING file:916a45030dee881bbc8bbabf8bcfcc8828c29ce1c318000950bbe84c57f9df73 doesn't exist, ensure exists for build
WARNING in doesn't exist, ensure exists for build
WARNING file:916a45030dee881bbc8bbabf8bcfcc8828c29ce1c318000950bbe84c57f9df73 doesn't exist, ensure exists for build
WARNING file:9b4a3bab37138e63b3f617bb597d97bf2a424461871c5de1a794c4e60d1010e9 doesn't exist, ensure exists for build
WARNING in doesn't exist, ensure exists for build
WARNING file:9b4a3bab37138e63b3f617bb597d97bf2a424461871c5de1a794c4e60d1010e9 doesn't exist, ensure exists for build
```

-------------------------------------------
## Pull image
For Docker use a pre-built [paddlepaddle Docker image](https://hub.docker.com/r/paddlepaddle/paddle)

```bash
docker pull paddlepaddle/paddle:1.2-gpu-cuda9.0-cudnn7
```

## Run the container (Local Workstation)
* First --volume mounts the current working directory (the sentiment_analysis directory)
* Second --volume mounts the data location as the data location that the benchmark program expects (/~/.cache/paddle/dataset/imdb)

Note: We pushed above docker image with our own tag to dockerhub and run that image, hence different image name.

Change your working directory to the sub-directory containing the sentiment_analysis benchmark code:
```bash
cd ${HOME}/git/afit_mlperf_training/sentiment_analysis
```

### Interactive bash prompt:
```bash
sudo docker run \
  --volume $(pwd):/sentiment_analysis \
  --volume /mnt/NAS/shared_data/afit_mlperf/training/sentiment_analysis:/root/.cache/paddle/dataset/imdb \
  --interactive \
  --tty \
  cgret/sentiment_analysis:sa_1.2-gpu-cuda9.0-cudnn7 \
  /bin/bash
```


### Directly run the benchmark on the 0th GPU
The sentiment_analsys benchmark program only uses a single GPU. This example specifies only the 0th GPU using the NV_GPU environment variable.  If the benchmark segfaults you might need to check that no one else is already using the GPU you specified with NV_GPU (ues the nvidia-smi command to see the GPU utilization and running GPU processes).

```bash
sudo NV_GPU=0 nvidia-docker run \
  --volume $(pwd):/sentiment_analysis \
  --volume ${MLPERF_DATA_DIR}/sentiment_analysis:/root/.cache/paddle/dataset/imdb \
  --interactive \
  --tty \
  cgret/sentiment_analysis:sa_1.2-gpu-cuda9.0-cudnn7 \
  /bin/bash /sentiment_analysis/paddle/run_and_time.sh
```

Need to work on capturing the output of each run or extracting the output from docker logs.

As an initial attempt:
```bash
sudo NV_GPU=0 nvidia-docker run \
  --volume $(pwd):/sentiment_analysis \
  --volume ${MLPERF_DATA_DIR}/sentiment_analysis:/root/.cache/paddle/dataset/imdb \
  --interactive \
  --tty \
  cgret/sentiment_analysis:sa_1.2-gpu-cuda9.0-cudnn7 \
  /bin/bash /sentiment_analysis/paddle/run_and_time.sh \
```

# Native version
The native version can be run interactive from the command line or as a PBS job in the HPC environment.  You will need to configure a runtime environment that is compatible with the containerized version.  We are using conda to manage python dependencies and the GUN Environment Modules system to manage dependencies like the compiler version, CUDA API, and cuDNN version.

The examples shown below assume that you have loaded a GNU Environment Module for the correct CUDA API version and cuDNN version.  Check the PBS scripts for examples.

## On mustang
Create a conda environment for [PaddlePaddle](https://github.com/PaddlePaddle/Paddle) on Mustang
 with:
```bash
conda activate base
conda create --name paddlepaddle-gpu
conda activate paddlepaddle-gpu
conda install pip
pip install paddlepaddle-gpu
```

Run with:
```bash
conda activate paddlepaddle-gpu
cd ${HOME}/git/afit_mlperf_training/sentiment_analysis
bash paddle/run_and_time.sh &> "$(hostname).$(date --date "now" +"%Y-%m-%d-%H-%M").native.log"
```

## On onyx
On Onyx (CUDA 8.0, cuDNN 7.1.3):
```bash
conda activate base
conda create --name paddlepaddle-cuda8cudnn7
conda activate paddlepaddle-cuda8cudnn7
conda install pip
pip install paddlepaddle-gpu==1.3.0.post87
```
Run with:
```bash
conda activate paddlepaddle-cuda8cudnn7
cd ${HOME}/git/afit_mlperf_training/sentiment_analysis
bash paddle/run_and_time.sh &> "$(hostname).$(date --date "now" +"%Y-%m-%d-%H-%M").native.log"
```


# References
 * [GPU isolation (version 1.0)](https://github.com/NVIDIA/nvidia-docker/wiki/GPU-isolation-(version-1.0))
 * [NVIDIA Docker and Container Best Practices](https://docs.nvidia.com/deeplearning/dgx/bp-docker)
 * [docker docs > CLI > docker run](https://docs.docker.com/engine/reference/commandline/run/)
 * [3. Benchmarks](https://github.com/mlperf/policies/blob/master/training_rules.adoc#3-benchmarks) - lists the benchmarks and quality targets.
