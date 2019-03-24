FROM paddlepaddle/paddle:latest-gpu-cuda9.0-cudnn7
ADD file:916a45030dee881bbc8bbabf8bcfcc8828c29ce1c318000950bbe84c57f9df73 in /
RUN /bin/sh -c set -xe 		\
    && echo '#!/bin/sh' > /usr/sbin/policy-rc.d 	\
    && echo 'exit 101' >> /usr/sbin/policy-rc.d 	\
    && chmod +x /usr/sbin/policy-rc.d 		\
    && dpkg-divert --local --rename --add /sbin/initctl 	\
    && cp -a /usr/sbin/policy-rc.d /sbin/initctl 	\
    && sed -i 's/^exit.*/exit 0/' /sbin/initctl 		\
    && echo 'force-unsafe-io' > /etc/dpkg/dpkg.cfg.d/docker-apt-speedup 		\
    && echo 'DPkg::Post-Invoke { "rm -f /var/cache/apt/archives/*.deb /var/cache/apt/archives/partial/*.deb /var/cache/apt/*.bin || true"; };' > /etc/apt/apt.conf.d/docker-clean 	\
    && echo 'APT::Update::Post-Invoke { "rm -f /var/cache/apt/archives/*.deb /var/cache/apt/archives/partial/*.deb /var/cache/apt/*.bin || true"; };' >> /etc/apt/apt.conf.d/docker-clean 	\
    && echo 'Dir::Cache::pkgcache ""; Dir::Cache::srcpkgcache "";' >> /etc/apt/apt.conf.d/docker-clean 		\
    && echo 'Acquire::Languages "none";' > /etc/apt/apt.conf.d/docker-no-languages 		\
    && echo 'Acquire::GzipIndexes "true"; Acquire::CompressionTypes::Order:: "gz";' > /etc/apt/apt.conf.d/docker-gzip-indexes 		\
    && echo 'Apt::AutoRemove::SuggestsImportant "false";' > /etc/apt/apt.conf.d/docker-autoremove-suggests
RUN /bin/sh -c rm -rf /var/lib/apt/lists/*
RUN /bin/sh -c mkdir -p /run/systemd \
    && echo 'docker' > /run/systemd/container
CMD ["/bin/bash"]
LABEL maintainer=NVIDIA CORPORATION <cudatools@nvidia.com>
RUN /bin/sh -c apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates apt-transport-https gnupg-curl \
    &&     rm -rf /var/lib/apt/lists/* \
    &&     NVIDIA_GPGKEY_SUM=d1be581509378368edeec8c1eb2958702feedf3bc3d17011adbf24efacce4ab5 \
    &&     NVIDIA_GPGKEY_FPR=ae09fe4bbd223a84b2ccfce3f60f4b3d7fa2af80 \
    &&     apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub \
    &&     apt-key adv --export --no-emit-version -a $NVIDIA_GPGKEY_FPR | tail -n +5 > cudasign.pub \
    &&     echo "$NVIDIA_GPGKEY_SUM  cudasign.pub" | sha256sum -c --strict - \
    && rm cudasign.pub \
    &&     echo "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64 /" > /etc/apt/sources.list.d/cuda.list \
    &&     echo "deb https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1604/x86_64 /" > /etc/apt/sources.list.d/nvidia-ml.list
ENV CUDA_VERSION=9.0.176
ENV CUDA_PKG_VERSION=9-0=9.0.176-1
RUN /bin/sh -c apt-get update \
    && apt-get install -y --no-install-recommends         cuda-cudart-$CUDA_PKG_VERSION \
    &&     ln -s cuda-9.0 /usr/local/cuda \
    &&     rm -rf /var/lib/apt/lists/*
LABEL com.nvidia.volumes.needed=nvidia_driver
LABEL com.nvidia.cuda.version=9.0.176
RUN /bin/sh -c echo "/usr/local/nvidia/lib" >> /etc/ld.so.conf.d/nvidia.conf \
    &&     echo "/usr/local/nvidia/lib64" >> /etc/ld.so.conf.d/nvidia.conf
ENV PATH=/usr/local/nvidia/bin:/usr/local/cuda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV LD_LIBRARY_PATH=/usr/local/nvidia/lib:/usr/local/nvidia/lib64
ENV NVIDIA_VISIBLE_DEVICES=all
ENV NVIDIA_DRIVER_CAPABILITIES=compute,utility
ENV NVIDIA_REQUIRE_CUDA=cuda>=9.0
LABEL maintainer=NVIDIA CORPORATION <cudatools@nvidia.com>
ENV NCCL_VERSION=2.4.2
RUN /bin/sh -c apt-get update \
    && apt-get install -y --no-install-recommends         cuda-libraries-$CUDA_PKG_VERSION         cuda-cublas-9-0=9.0.176.4-1         libnccl2=$NCCL_VERSION-1+cuda9.0 \
    &&     apt-mark hold libnccl2 \
    &&     rm -rf /var/lib/apt/lists/*
LABEL maintainer=NVIDIA CORPORATION <cudatools@nvidia.com>
ENV CUDNN_VERSION=7.4.2.24
LABEL com.nvidia.cudnn.version=7.4.2.24
RUN /bin/sh -c apt-get update \
    && apt-get install -y --no-install-recommends             libcudnn7=$CUDNN_VERSION-1+cuda9.0 \
    &&     apt-mark hold libcudnn7 \
    &&     rm -rf /var/lib/apt/lists/*
MAINTAINER PaddlePaddle Authors <paddle-dev@baidu.com>
ENV HOME=/root
ADD file:9b4a3bab37138e63b3f617bb597d97bf2a424461871c5de1a794c4e60d1010e9 in /
RUN /bin/sh -c apt-get update \
    && apt-get install -y --allow-downgrades libnccl2=2.2.13-1+cuda9.0 libnccl-dev=2.2.13-1+cuda9.0 || true
RUN /bin/sh -c apt-get install -y wget python-pip python-opencv libgtk2.0-dev dmidecode python-tk \
    && easy_install -U pip \
    &&         pip install /*.whl; apt-get install -f -y \
    &&         apt-get clean -y \
    &&         rm -f /*.whl \
    &&         paddle version \
    &&         ldconfig
RUN /bin/sh -c ln -sf /usr/lib/x86_64-linux-gnu/libcudnn.so.7 /usr/lib/x86_64-linux-gnu/libcudnn.so
RUN /bin/sh -c ln -sf /usr/local/cuda/targets/x86_64-linux/lib/libcublas.so.9.0 /usr/lib/x86_64-linux-gnu/libcublas.so
ENV LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu:/usr/local/nvidia/lib:/usr/local/nvidia/lib64
ENV NCCL_LAUNCH_MODE=PARALLEL
CMD ["paddle" "version"]
