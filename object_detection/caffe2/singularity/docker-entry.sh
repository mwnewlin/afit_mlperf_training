#!/bin/bash


#mkdir /packages/detectron/lib/datasets/data/coco
cd /packages/detectron/lib/datasets/data/coco
echo "Starting in directory: "$(pwd)

echo "Downloading Datasets"
# See: https://github.com/facebookresearch/Detectron/issues/814
#wget https://s3-us-west-2.amazonaws.com/detectron/coco/coco_annotations_minival.tgz
wget -N https://dl.fbaipublicfiles.com/detectron/coco/coco_annotations_minival.tgz
wget -N http://images.cocodataset.org/zips/train2014.zip
wget -N http://images.cocodataset.org/zips/val2014.zip
wget -N http://images.cocodataset.org/annotations/annotations_trainval2014.zip

echo "Downloading Weights"
# See: https://github.com/facebookresearch/Detectron/issues/1
# See: https://github.com/facebookresearch/Detectron/blob/master/MODEL_ZOO.md#imagenet-pretrained-models
#wget https://s3-us-west-2.amazonaws.com/detectron/ImageNetPretrained/MSRA/R-50.pkl
wget -N https://dl.fbaipublicfiles.com/detectron/ImageNetPretrained/MSRA/R-50.pkl

echo "Verifying Datasets"
if md5sum -c /hashes.md5
then
  echo "PASSED"

  dtrx --one=here coco_annotations_minival.tgz
  dtrx --one=here annotations_trainval2014.zip
  mv annotations.1/* annotations/
  dtrx train2014.zip
  mv train2014/ coco_train2014/
  dtrx val2014.zip
  mv val2014/ coco_val2014/

  cd /packages/detectron
  time stdbuf -o 0 \
    python tools/train_net.py --cfg configs/12_2017_baselines/e2e_mask_rcnn_R-50-FPN_1x.yaml \
    --box_min_ap 0.377 --mask_min_ap 0.339 \
    --seed 3 | tee run.log
else
  echo "data set verification FAILED"
fi




#sudo nvidia-docker run -v /mnt/disks/data/coco/:/packages/detectron/lib/datasets/data/coco -it detectron /bin/bash

#time stdbuf -o 0 \
#  python tools/train_net.py --cfg configs/12_2017_baselines/e2e_mask_rcnn_R-50-FPN_1x.yaml \
#    --box_min_ap 0.377 --mask_min_ap 0.339 \
#    --seed 3 | tee run.log
