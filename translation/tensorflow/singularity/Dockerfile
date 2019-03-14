FROM nvidia/cuda:9.0-cudnn7-runtime-ubuntu16.04


WORKDIR /research
RUN apt-get update
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    build-essential \
    git \
    nano \
    python \
    python-pip
ENV HOME /research
ENV PYENV_ROOT $HOME/.pyenv
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH
RUN apt-get install -y python-setuptools
RUN apt-get install -y python-pip python3-pip virtualenv htop
RUN pip3 install --upgrade numpy scipy sklearn tensorflow-gpu==1.9.0

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

# Mount data into the docker
ADD . /research/transformer
WORKDIR /research/transformer
RUN pip3 install -r requirements.txt
ENTRYPOINT ["/bin/bash"]




#cd translation/tensorflow
#IMAGE=`sudo docker build . | tail -n 1 | awk '{print $3}'`
#SEED=1
#NOW=`date "+%F-%T"`
#sudo docker run \
#    --runtime=nvidia \
#    -v $(pwd)/translation/raw_data:/raw_data \
#    -v $(pwd)/compliance:/mlperf/training/compliance \
#    -e "MLPERF_COMPLIANCE_PKG=/mlperf/training/compliance" \
#    -t -i $IMAGE "./run_and_time.sh" $SEED | tee benchmark-$NOW.log
