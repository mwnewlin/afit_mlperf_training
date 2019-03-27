# See: https://github.com/facebookresearch/Detectron/issues/1
# See: https://github.com/facebookresearch/Detectron/blob/master/MODEL_ZOO.md#imagenet-pretrained-models
#wget https://s3-us-west-2.amazonaws.com/detectron/ImageNetPretrained/MSRA/R-50.pkl
mkdir -p data; cd data
wget -N https://dl.fbaipublicfiles.com/detectron/ImageNetPretrained/MSRA/R-50.pkl
