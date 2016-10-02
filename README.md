# docker-mc-backuprestore

Simple backup & restore image using Minio.

- Base on croney, which is an alpine glibc hack with devcron, allowing simple cron like scripts
- Run one time mirror using /scripts/mc-mirror-src2dest.sh


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