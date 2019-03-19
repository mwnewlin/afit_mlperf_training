# Setup

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


# References

[PyTorch](https://pytorch.org/get-started/locally/)


