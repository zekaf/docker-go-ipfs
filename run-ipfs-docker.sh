#!/bin/bash
#
# Create docker container
#

if [ -z "$1" ]; then
 echo
 echo "Usage: ./$(basename $0) <container_name>"
 echo
 exit 1
fi

STAGING_DIR="/opt/docker/data/ipfs-export"
DATA_DIR="/opt/docker/data/ipfs"

# Docker image
IMG="zekaf/go-ipfs"
TAG="latest"

# Docker IPFS container
IPFS_CT="$1"

docker run -d \
	--name $IPFS_CT \
	--restart=always \
	--volume $STAGING_DIR:/export --volume $DATA_DIR:/data/ipfs \
	-p 4001:4001 -p 5001:5001 -p 8080:8080 \
	$IMG:$TAG




