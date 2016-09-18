#!/bin/bash

if [ "$UPLOAD_SOURCE" ]; then
   mc config host add "s3-src" "$UPLOAD_SOURCE" "$UPLOAD_SOURCE_KEY" "$UPLOAD_SOURCE_SECRET" S3v4 
   echo "Source: $UPLOAD_SOURCE/$UPLOAD_SOURCE_BUCKET - $UPLOAD_SOURCE_KEY"
   mc ls s3-src

   SOURCE=s3-src/$UPLOAD_SOURCE_BUCKET
fi

if [ "$UPLOAD_DEST" ]; then
   mc config host add "s3-dest" "$UPLOAD_DEST" "$UPLOAD_DEST_KEY" "$UPLOAD_DEST_SECRET" S3v4 

   echo "Dest: $UPLOAD_DEST/$UPLOAD_DEST_BUCKET - $UPLOAD_DEST_KEY"
   mc ls s3-dest

   DEST=s3-dest/$UPLOAD_DEST_BUCKET
   mc mb $DEST
fi

if [ "$UPLOAD_SOURCE_FOLDER" ]; then
   SOURCE=UPLOAD_SOURCE_FOLDER
fi

if [ "$UPLOAD_DEST_FOLDER" ]; then
   DEST=UPLOAD_DEST_FOLDER
fi

#TODO: Check source and dest...
mc $UPLOAD_OPTIONS mirror $SOURCE $DEST --force

