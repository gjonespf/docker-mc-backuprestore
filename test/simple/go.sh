#!/bin/bash
./cleanup.sh

#Build test volume
test_volume_name=docker-mc-backuprestore-test

docker volume rm $test_volume_name
docker volume create --name "$test_volume_name"
docker run --rm -it --name docker-toolbox-test -v $test_volume_name:/mnt/storage gavinjonespf/docker-toolbox:latest bash -c "mkdir /mnt/storage/src && for i in {1..50}; do touch /mnt/storage/src/testfile-$i; done" 

docker-compose up -d minio-test
docker-compose ps

docker-compose up backup-test
