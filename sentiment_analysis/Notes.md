There is a Dockerhub image for paddle
https://hub.docker.com/r/paddlepaddle/paddle

This benchmark uses a [dataset](http://www.paddlepaddle.org/documentation/docs/en/develop/api/data/dataset.html) module
to access the IMDB data.  The default location used by the module is '~/.cache/paddle/dataset/imdb'.


I created a conda environment for [PaddlePaddle](https://github.com/PaddlePaddle/Paddle) on Mustang with:
```bash
conda activate base
conda create --name paddlepaddle-gpu
conda activate paddlepaddle-gpu
conda install pip
pip install paddlepaddle-gpu
```


On Onyx (CUDA 8.0):
```bash
conda activate base
conda create --name paddlepaddle-cuda8cudnn7
conda activate paddlepaddle-cuda8cudnn7
conda install pip
pip install paddlepaddle-gpu==1.3.0.post87
```



