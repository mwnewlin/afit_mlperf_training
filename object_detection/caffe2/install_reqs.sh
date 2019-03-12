#!/bin/bash

# requires CUDA 9.1 and cuDNN 7.1
# moduels are already installed

# Caffe2 depends
sudo apt-get update
sudo apt-get install -y --no-install-recommends \
      build-essential \
      cmake \
      git \
      libgoogle-glog-dev \
      libgtest-dev \
      libiomp-dev \
      libleveldb-dev \
      liblmdb-dev \
      libopencv-dev \
      libopenmpi-dev \
      libsnappy-dev \
      libprotobuf-dev \
      openmpi-bin \
      openmpi-doc \
      protobuf-compiler \
      python-dev \
      python-pip
sudo apt-get install -y --no-install-recommends libgflags-dev
conda activate base
conda create -n object_detection
conda activate object_detection
pip install setuptools
pip install --upgrade pip==9.0.3
pip install \
      future \
      numpy \
      protobuf

# Detectron depends
pip install \
     numpy pyyaml matplotlib opencv-python>=3.2 setuptools Cython mock scipy

# Hidden dependancies
pip install networkx enum

# Build and install caffe2
WORKDIR="${HOME}/afit_mlperf_packages"
mkdir ${WORKDIR}
cd ${WORKDIR}
git clone https://github.com/pytorch/pytorch.git caffe2
cd  ${WORKDIR}/caffe2
git checkout v0.4.1
git submodule update --init --recursive
cd ${WORKDIR}/caffe2
mkdir ${WORKDIR}/caffe2/build
cd ${WORKDIR}/caffe2/build
cmake ..
make install -j16

# Build and install the COCO API
cd ${WORKDIR}
RUN git clone https://github.com/cocodataset/cocoapi.git
cd ${WORKDIR}/cocoapi/PythonAPI
make install

# Build detectron
cd ${WORKDIR} 
git clone https://github.com/ddkang/Detectron.git detectron
cd ${WORKDIR}/detectron
git checkout benchmarking
cd ${WORKDIR}/detectron/lib
make
cd ${WORKDIR}/detectron/lib/datasets/data
# RUN ln -s /data coco/
cd ${WORKDIR}/detectron 
