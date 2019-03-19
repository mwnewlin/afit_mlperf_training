For Docker version run

Use pre-built paddlepaddle Docker image 

```bash
docker pull paddlepaddle/paddle:1.2-gpu-cuda9.0-cudnn7
```
Command to run the container.
* First -v mounts the working directory (the sentiment_analysis directory)
* Second -v mounts the data location as the data location that the program expects (/~/.cache/paddle/dataset/imdb)
Note: We pushed above docker image with our own tag to dockerhub and run that image, hence different image name.

```bash
sudo docker run -v `pwd`:/sentiment_analysis -v /mnt/NAS/shared_data/afit_mlperf/training/sentiment_analysis:/root/.cache/paddle/dataset/imdb -it cgret/sentiment_analysis:sa_1.2-gpu-cuda9.0-cudnn7 /bin/bash
```
