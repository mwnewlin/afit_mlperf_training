# Setup

Note that this requires you to set a MLPERF_DATA_DIR environment
variable.

Create conda environment
```bash
conda activate
conda create --name pytorch-gpu
conda activeate pytorch-gpu
conda install pip
conda install pytorch torchvision cudatoolkit=9.0 -c pytorch
pip install sacrebleu numpy mlperf-compliance
```


