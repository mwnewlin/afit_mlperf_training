
# Notes
The translation benchmark was not converging with a BLEU of 25.  I ran ten jobs on Mustang for 96 hours that never converged.  Reduced the BLEU score to 20 in translation/tensorflow/run_and_time.sh to see if the jobs will converge in a reasonable time.

# Setup
Requires Tensorflow 1.9.0, Tensorflow 1.9.0 requires Python 3.6, CUDA 9.0 and cuDNN 7.1.4.

```bash
conda activate base
conda create -n tensorflow-1.9.0-gpu pip python=3.6
conda activate tensorflow-1.9.0-gpu
cd tensorflow
pip install --ignore-installed -r requirements.txt
pip install --ignore-installed --upgrade https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow_gpu-1.9.0-cp36-cp36m-linux_x86_64.whl
```
See: [Install TensorFlow with pip](https://www.tensorflow.org/install/pip)

You might get numpy version conflicts.  In that case remove all installed numpy from the tensorflow-1.9.0 environment and reinstall a new one.  For example, I had to uninstall two versions of numpy and the install a current version:
```bash
pip uninstall numpy
pip uninstall numpy
pip install numpy
```



On the DL/ML boxes:
```bash
module unload cuda
module load devel/cuda/9.0
```

On mustang select the correct CUDA and cuDNN with:
```bash
module unload cuda
module load devel/cuda/9.0
module load cudnn/cuda9.0/7.4.2
```

Onyx is a bit more involved because it's a Cray XC40/50.  All the GPUs are on compute nodes.  You'll need to use cluster compatility mode (CCM) and the  GNU programming environment module.  To build and install a conda environment with tensorflow 1.9.0:
```bash
module load ccm
module swap PrgEnv-cray PrgEnv-gnu
module unload cuda
module load devel/cuda/9.0
module load cudnn/cuda/9.0/7.4.2

conda activate base
conda create -n tensorflow-1.9.0-gpu pip python=3.6
conda activate tensorflow-1.9.0-gpu
cd tensorflow
pip install --ignore-installed -r requirements.txt
pip install --ignore-installed --upgrade https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow_gpu-1.9.0-cp36-cp36m-linux_x86_64.whl
```
Then run the test.

# Docker images
There are official Tensorflow images on dockerhub
at [tensorflow/tensorflow](https://hub.docker.com/r/tensorflow/tensorflow).
The images are based on Ubuntu 16.04.

The 1.9.0 tags are:
    1.9.0-devel-gpu-py3
    1.9.0-devel-gpu
    1.9.0-devel-py3
    1.9.0-devel
    1.9.0-gpu-py3
    1.9.0-gpu
    1.9.0-py3
    1.9.0

To start a GPU container with Python 3:
```bash
docker run -it --rm --runtime=nvidia tensorflow/tensorflow:1.9.0-gpu-py3 python
```

# References

 * [3. Benchmarks](https://github.com/mlperf/policies/blob/master/training_rules.adoc#3-benchmarks) - lists the benchmarks and quality targets.

 * [Which TensorFlow and CUDA version combinations are compatible?](https://stackoverflow.com/questions/50622525/which-tensorflow-and-cuda-version-combinations-are-compatible)
 * [Tested build configurations](https://www.tensorflow.org/install/source#tested_build_configurations)