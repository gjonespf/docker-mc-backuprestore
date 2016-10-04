#!/bin/bash

if [ "$UPLOAD_SOURCE" ]; then
   mc config host add "s3-src" "$UPLOAD_SOURCE" "$UPLOAD_SOURCE_KEY" "$UPLOAD_SOURCE_SECRET" S3v4 
   echo "Source: $UPLOAD_SOURCE/$UPLOAD_SOURCE_BUCKET - $UPLOAD_SOURCE_KEY"
   SOURCE=s3-src/$UPLOAD_SOURCE_BUCKET

   mc ls $SOURCE
fi

if [ "$UPLOAD_DEST" ]; then
   mc config host add "s3-dest" "$UPLOAD_DEST" "$UPLOAD_DEST_KEY" "$UPLOAD_DEST_SECRET" S3v4 
   echo "Dest: $UPLOAD_DEST/$UPLOAD_DEST_BUCKET - $UPLOAD_DEST_KEY"
   mc ls s3-dest

   if [ "$UPLOAD_DEST_BUCKET" ]; then
      echo "Ensuring dest bucket '$UPLOAD_DEST_BUCKET' exists"
      DEST=s3-dest/$UPLOAD_DEST_BUCKET
      mc mb $DEST
      mc ls $DEST
   else
      echo "No dest bucket, we will iterate over source and create a bucket for each folder in src"
      DEST=s3-dest
      mc ls $DEST
   fi
fi

if [ "$UPLOAD_SOURCE_FOLDER" ]; then
   echo "Using source folder: $UPLOAD_SOURCE_FOLDER"
   SOURCE=$UPLOAD_SOURCE_FOLDER
fi

if [ "$UPLOAD_DEST_FOLDER" ]; then
   echo "Using dest folder: $UPLOAD_DEST_FOLDER"
   DEST=$UPLOAD_DEST_FOLDER
fi

if [ "$UPLOAD_DEST_BUCKET" ] || [ "$UPLOAD_DEST_FOLDER" ]; then

   #TODO: Check source and dest...
   echo "Using: mc mirror '$UPLOAD_OPTIONS' '$SOURCE' '$DEST'"
   mc mirror $UPLOAD_OPTIONS $SOURCE $DEST

else

   srcbuckets=$(mc --json ls $SOURCE \
   | sed 's/"size":0,//' \
   | sed -re 's/"lastModified":"[0-9.T:+-]*",//' \
   | sed '$ ! s/$/,/' )
   srcbuckets=$(echo "[ $srcbuckets ]")
   #echo "$srcbuckets"

   declare -A assoc_array="($(
   echo "$srcbuckets" \
   | jq '.[]  | "[" + .key + "]=\"" +.status + "\""' -r
   ))"

   for key in ${!assoc_array[@]}; do 
      echo "- Working on src directory $key"
      bucketname=$key;
      status=${assoc_array[$key]};

      destbucket=$DEST/$bucketname
      #echo "Dest: $destbucket"

      mc mb $destbucket
      echo "Using: mc mirror '$UPLOAD_OPTIONS' '$SOURCE/$bucketname' '$destbucket'"
      mc mirror $UPLOAD_OPTIONS $SOURCE/$bucketname $destbucket
   done  

fi
