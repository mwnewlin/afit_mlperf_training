# Setup
Requires Tensorflow 1.9.0
```bash
conda activate base
conda create -n afit_mlperf_translation pip python=3.6
conda activate afit_mlperf_translation
cd tensorflow
pip install --ignore-installed -r requirements.txt
pip install --ignore-installed --upgrade https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow_gpu-1.9.0-cp36-cp36m-linux_x86_64.whl
```
See: [Install TensorFlow with pip](https://www.tensorflow.org/install/pip)


Tensorflow 1.9.0 needs CUDA 9.0 and cuDNN 7.1.4.
See:
  [Which TensorFlow and CUDA version combinations are compatible?](https://stackoverflow.com/questions/50622525/which-tensorflow-and-cuda-version-combinations-are-compatible)
  [Tested build configurations](https://www.tensorflow.org/install/source#tested_build_configurations)

On the DL/ML boxes:
```bash
module unload cuda
module load devel/cuda/9.0
```

Then run the test.

