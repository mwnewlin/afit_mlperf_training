
## Singularity friendly Docker Image of MLPerf Object Detection benchmark (Using caffe2)
Dockerfile and docker-entry workflow was modified to work in a non-permissive Singularity environment (i.e. a HPC)


## Pulling image with Singularity
````bash
singularity pull --name mlperf_object_detection.simg docker://cgret/mlperf_object_detection:0.5
````

## Running in Singularity
````bash
 mkdir $(pwd)/object
singularity run --nv --bind $(pwd)/train:/packages/detectron/train --bind $(pwd)/object:/packages/detectron/lib/datasets/data/coco mlperf_object_detection.simg
````

### Notes
- **requires a "GPU"** (P100 was used in original benchmark, mileage may vary based on GPU RAM)
- Dataset should automatically download on the first run
- Results will print to STDOUT

## Building new Docker image base

Download all files in this folder and run (from the same folder)
````bash
docker build -t mlperf_recomendation_pytorch:0.5 .
````


##TODO
- Collect results in a file
