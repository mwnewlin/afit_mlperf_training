# Native 

## Setup
Note that this requires you to set a MLPERF_DATA_DIR environment
variable.

Create conda environment:
```bash
conda activate
conda create --name pytorch-gpu
conda activate pytorch-gpu
conda install pip
conda install pytorch torchvision cudatoolkit=9.0 -c pytorch
pip install sacrebleu numpy mlperf-compliance
```

Onyx has CUDA 8.0 so install pytorch with:
```bash
conda install pytorch torchvision cudatoolkit=8.0 -c pytorch
```
The other steps are the same.

## Run
Active the conda environment:
```bash
conda activate pytorch-gpu
````
Run the benchmark:
```bash
cd cd ${HOME}/git/afit_mlperf_training/rnn_translator/pytorch
bash run_and_time.sh
```
You can log the results to a file by redirecting stdout and stderr:
```bash
RUN_DATE=`date --date "${START_TIME}" +"%Y-%m-%d-%H-%M"` ; \
LOG_FILE="$(hostname).${RUN_DATE}.native.log" ; \
bash pytorch/run_and_time.sh &> ${LOG_FILE}
```
# Singularity
These steps assume that you've cloned the repository to ~/git/afit_mlperf_training 
and that you have set the MLPERF_DATA_DIR environment variable
to point to the directory containing the downloaded data.

## DL/ML boxes
On the DL/ML boxes define the location of singularity containers using 
the SINGULARITY_CONTAINER_PATH enviornment variable.  Add the following
to your ~/.bashrc and ~/.bash_login:
```bash
export SINGULARITY_CONTAINER_PATH="${HOME}/singularity"
mkdir -p ${SINGULARITY_CONTAINER_PATH}
```

Build an image with:
```bash
cd ${HOME}/git/afit_mlperf_training/rnn_translator
sudo singularity build rnn_translation.simg Singularity.rnn_translator
mv rnn_translation.simg ${SINGULARITY_CONTAINER_PATH}
```

Run the container with:
```bash
cd ${HOME}/git/afit_mlperf_training/rnn_translator
sudo \
MLPERF_DATA_DIR="/mnt/NAS/shared_data/afit_mlperf/training/" \
sudo singularity exec \
    --nv \
    --bind $(pwd):/benchmark \
    --bind ${MLPERF_DATA_DIR}:/data \
    ${SINGULARITY_CONTAINER_PATH}/rnn_translator.simg \
    /bin/bash  /benchmark/pytorch/run_and_time.sh 
```

## HPC
You will not be able to build the containers on the HPC without sudo privledges.  You can build the images on another box and transfer them via scp or use the images from Singularity hub.

To download the image from Singularity hub:
```bash
pushd .
cd ${SINGULARITY_CONTAINER_PATH}
singularity pull \
   --name rnn_translator.simg  \
   shub://mark-e-deyoung/afit_mlperf_training:rnn_translator
popd
```

You will not be able to directly exec the image.  You
will need to start an interactive shell and then run the 
benchmark:
```bash
cd ${HOME}/git/afit_mlperf_training/rnn_translator
singularity run \
    --nv \
    --bind $(pwd):/benchmark \
    --bind ${MLPERF_DATA_DIR}:/data \
    ${SINGULARITY_CONTAINER_PATH}/rnn_translator.simg
```

# References

[PyTorch](https://pytorch.org/get-started/locally/)


