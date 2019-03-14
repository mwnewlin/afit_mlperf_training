

## Singularity friendly Docker Image of MLPerf Recommendation benchmark (Using intel caffe)
Dockerfile and docker-entry workflow was modified to work in a non-permissive Singularity environment (i.e. a HPC)


## Pulling image with Singularity
````bash
singularity pull --name mlperf_recomendation_intelncf.simg docker://cgret/mlperf_recomendation_intelncf:0.5
````

## Running in Singularity
````bash
singularity run mlperf_recomendation_intelncf.simg
````

### Notes
- **CPU only test**
- Dataset should automatically download on the first run
- Results will print to STDOUT


## Building new Docker image base
Download all files in this folder and run (from the same folder)
````bash
docker build -t mlperf_recomendation_intelncf:0.5 .
````


##TODO
- Collect results to file
- Enable command line SEED / parallelism values
