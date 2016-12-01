#!/bin/bash

#Add hosts based on env vars to MC 
if [ "$VERBOSE" ]; then
echo "Using env:"
echo "==================================="
env
echo "Using parms (passed in, will replace UPLOAD_OPTIONS):"
echo "Total $# arguments: $*"
echo "==================================="
fi

#Use passed in arguments to override options to MC
if [ -n "$1" ]; then
    UPLOAD_OPTIONS=$*
fi

if [ "$UPLOAD_SOURCE" ]; then
   mc config host add "s3-src" "$UPLOAD_SOURCE" "$UPLOAD_SOURCE_KEY" "$UPLOAD_SOURCE_SECRET" S3v4 
   echo "Source: $UPLOAD_SOURCE/$UPLOAD_SOURCE_BUCKET - $UPLOAD_SOURCE_KEY"
fi

if [ "$UPLOAD_DEST" ]; then
   mc config host add "s3-dest" "$UPLOAD_DEST" "$UPLOAD_DEST_KEY" "$UPLOAD_DEST_SECRET" S3v4 
   echo "Dest: $UPLOAD_DEST/$UPLOAD_DEST_BUCKET - $UPLOAD_DEST_KEY"
fi
