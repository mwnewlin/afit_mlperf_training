#!/bin/bash

# Build and install caffe2
WORKDIR=${1:-"${HOME}/afit_mlperf_packages"}

mkdir -p ${WORKDIR}
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
