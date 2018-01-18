# docker-mc-backuprestore

Simple backup & restore image using Minio.

- Base on https://github.com/gjonespf/docker-croney, which is an alpine glibc hack with devcron, allowing simple cron like scripts
- Alternatively, run one time mirror using /scripts/mc-mirror-src2dest.sh (e.g. using "entrypoint: /app/scripts/mc-mirror-src2dest.sh")

Env vars:

- $UPLOAD_SOURCE - s3 source server 
- $UPLOAD_SOURCE_KEY
- $UPLOAD_SOURCE_SECRET
- $UPLOAD_SOURCE_BUCKET

- $UPLOAD_SOURCE_FOLDER - alternative source folder, instead of a s3 server

- $UPLOAD_DEST - s3 dest server
- $UPLOAD_DEST_KEY
- $UPLOAD_DEST_SECRET
- $UPLOAD_DEST_BUCKET

- $UPLOAD_DEST_FOLDER - alternative dest folder, instead of a s3 server

- $UPLOAD_OPTIONS - Options for mc - you probably want to at least set this to UPLOAD_OPTIONS=--quiet

Testing:
- Explore image using: docker run -it --entrypoint /bin/bash gavinjonespf/docker-mc-backuprestore
- Test run using: docker run -it gavinjonespf/docker-mc-backuprestore /app/files/default-crontab

On Docker hub as:
- https://hub.docker.com/r/gavinjonespf/docker-mc-backuprestore/
- docker pull gavinjonespf/docker-mc-backuprestore
