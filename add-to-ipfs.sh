#!/bin/bash
#
# Add host file/dir to IPFS container
#
# Add file example:
# $ echo "123" > test.txt
# $ sudo ./add-to-ipfs.sh ipfs-node ./test.txt
# added QmTEzo7FYzUCd5aq7bGKoMLfsbbsebpfARRZd4Znejb25R test.txt
# $ docker exec -it 'ipfs-node' ipfs cat QmTEzo7FYzUCd5aq7bGKoMLfsbbsebpfARRZd4Znejb25R
# 123
#
# Add dir example:
# $ mkdir test-dir
# $ echo "456" > ./test-dir/test.txt
# $ sudo ./add-to-ipfs.sh ipfs-node ./test-dir
# added QmPgW6BkabgZAgHnytZQesjhGjEFmtAs4AyANLwgJtnYaQ test-dir/test.txt
# added Qmb7t2RVNuMY1DCrC4sEodMcDzGbnKUEtBGbfqBzM3YUQH test-dir
# $ docker exec -it 'ipfs-node' ipfs cat Qmb7t2RVNuMY1DCrC4sEodMcDzGbnKUEtBGbfqBzM3YUQH/test.txt
# 456

if [ "$#" -ne 2 ]; then
 echo
 echo "Usage: ./$(basename $0) <container_name> <file/dir>"
 echo
 exit 1
fi

# IPFS container
IPFS_CT="$1"

# host staging directory
STAGING_DIR="/opt/docker/export/$IPFS_CT"

# copy file/dir to staging directory
cp -r $2 $STAGING_DIR

# add file/dir to IPFS container
if [ -d "$2" ]; then
   docker exec $IPFS_CT ipfs add -r /export/$2
else
   docker exec $IPFS_CT ipfs add /export/$2
fi
