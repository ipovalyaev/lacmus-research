#!/bin/bash

apt-get update
apt-get install -y libsm6 libxext6 libxrender-dev
pip install opencv-python

cd /storage/lacmus/

pip install . --user

mkdir logs/combined_model_e2-5

keras_retinanet/bin/train.py --weights ./snapshots/funetuning_e1.h5 --epoch 1 --tensorboard-freq 100 --config config.ini --batch-size 1 --image-min-side 1500 --image-max-side 2000 --lr 0.000001 --optimizer-clipnorm 0.01 --tensorboard-dir logs/combined_model_e2-5 pascal /storage/data/LADDV4_Full >> logs/combined_model_e2-5/output.log

mkdir /artifacts/combined_model_e2-5
cp logs/combined_model_e2-5/* /artifacts/combined_model_e2-5/
cp snapshots/resnet50_pascal_01.h5 /artifacts/combined_model_e2-5/funetuning_e2-5.h5  

