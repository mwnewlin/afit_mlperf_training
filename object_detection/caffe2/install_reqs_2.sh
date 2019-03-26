#!/bin/bash

conda activate base
conda create -n object_detection conda
conda activate object_detection
#pip install setuptools
#pip install --upgrade pip==9.0.3
pip install \
      future \
      numpy \
      protobuf

# Detectron depends
pip install \
     numpy pyyaml matplotlib opencv-python>=3.2 setuptools Cython mock scipy

# Hidden dependancies
pip install networkx enum

