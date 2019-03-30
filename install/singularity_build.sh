#!/bin/bash

SINGULARITY_FILE="$(basename $1)"

# use the extension as the image name
IMG_NAME="${SINGULARITY_FILE#*.}.simg"

singularity build ${IMG_NAME} $1
