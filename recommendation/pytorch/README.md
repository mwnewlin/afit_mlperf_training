
## Singularity friendly Docker Image of MLPerf Recommendation benchmark (Using pytorch)
Dockerfile and docker-entry workflow was modified to work in a non-permissive Singularity environment (i.e. a HPC)


## Pulling image with Singularity
````bash
singularity pull --name mlperf_recomendation_pytorch.simg docker://cgret/mlperf_recomendation_pytorch:0.5
````

## Running in Singularity
````bash
 mkdir $(pwd)/experiment
 singularity shell --nv --bind $(pwd)/experiment:/mlperf/experiment mlperf_recomendation_pytorch.simg
 bash /docker-entry.sh
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
- Make singularity one liner
- Collect results in a file
