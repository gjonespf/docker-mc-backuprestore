#!/bin/bash
#TODO: Generic helper image...
mc config host add "s3-src" "$UPLOAD_SOURCE" "$UPLOAD_SOURCE_KEY" "$UPLOAD_SOURCE_SECRET" S3v4 
mc config host add "s3-dest" "$UPLOAD_DEST" "$UPLOAD_DEST_KEY" "$UPLOAD_DEST_SECRET" S3v4 

echo "Source: $UPLOAD_SOURCE/$UPLOAD_SOURCE_BUCKET - $UPLOAD_SOURCE_KEY"
mc ls s3-src

echo "Dest: $UPLOAD_DEST/$UPLOAD_DEST_BUCKET - $UPLOAD_DEST_KEY"
mc ls s3-dest

mc mb s3-dest/$UPLOAD_DEST_BUCKET
mc $UPLOAD_OPTIONS mirror s3-src/$UPLOAD_SOURCE_BUCKET s3-dest/$UPLOAD_DEST_BUCKET --force

