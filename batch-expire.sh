#!/bin/bash
#

mc mb myminio/bucket
mc version enable myminio/bucket
mc admin config set myminio batch expiration_workers_wait=5ms

mc anonymous set public myminio/bucket

for i in {1..20}
do
   for j in {1..5}
   do
      if ((i%2 == 0))
      then 
         curl -XPUT http://localhost:9000/bucket/prefix-1/obj-${i} -d @/etc/issue -H "X-Minio-Source-Mtime: 2023-07-04T12:01:04.1152098${j}-08:00" -H "x-amz-tagging: name=pick-1" 	
      else 
	 curl -XPUT http://localhost:9000/bucket/prefix-1/obj-${i} -d @/etc/issue -H "X-Minio-Source-Mtime: 2023-07-04T12:01:04.1152098${j}-08:00"
      fi
      if ((i%2 == 1)) && ((j == 5))
      then
      # Create DEL marker
        curl -X DELETE http://127.0.0.1:9000/bucket/prefix-1/obj-${i} -H "X-Minio-Source-Mtime: 2023-07-04T12:06:04.115209866-08:00"
      fi
   done
done

for i in {1..20}; do 
 for j in {1..2}; do
 if ((i%2 == 0))
 then 
   curl -XPUT http://localhost:9000/bucket/prefix-2/obj-${i} -d @/etc/issue -H "X-Minio-Source-Mtime: 2023-07-05T12:01:04.1152098${j}-08:00" -H "x-amz-tagging: name=pick-2" 	
 else 
   curl -XPUT http://localhost:9000/bucket/prefix-2/obj-${i} -d @/etc/issue -H "X-Minio-Source-Mtime: 2023-07-05T12:01:04.1152098${j}-08:00" 
 fi
 done
done

