#!/bin/bash
#

./mc mb myminio/bucket
./mc version enable myminio/bucket

./mc anonymous set public myminio/bucket

for i in {1..50}
do
   curl -XPUT http://localhost:9000/bucket/prefix/obj-1 -d @/etc/issue -H "X-Minio-Source-Mtime: 2023-07-04T12:01:04.1152098${i}-08:00" -H "x-amz-tagging: name=pick-1" 	
    curl -XPUT http://localhost:9000/bucket/prefix/obj-2 -d @/etc/issue -H "X-Minio-Source-Mtime: 2023-07-04T12:01:04.1152098${i}-08:00"
done

# Create DEL marker
 curl -X DELETE http://127.0.0.1:9000/bucket/prefix/obj-2 -H "X-Minio-Source-Mtime: 2023-07-04T12:06:04.115209866-08:00"


