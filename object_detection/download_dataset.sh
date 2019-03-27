# See: https://github.com/facebookresearch/Detectron/issues/814
#wget https://s3-us-west-2.amazonaws.com/detectron/coco/coco_annotations_minival.tgz
mkdir -p data; cd data
wget -N https://dl.fbaipublicfiles.com/detectron/coco/coco_annotations_minival.tgz
wget -N http://images.cocodataset.org/zips/train2014.zip
wget -N http://images.cocodataset.org/zips/val2014.zip
wget -N http://images.cocodataset.org/annotations/annotations_trainval2014.zip

