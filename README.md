# Introduction

Batch-expiry enables expiry of objects and its versions based on a set of filter conditions like object tags, metadata, etc.

The details of the objects to be expired is specified by a yaml file.


# Usage

This repository contains a shell script file which sets up a bucket with 2 objects, each with 50 versions.
It also contains a sample expiry.yaml file which specifies a few filter conditions like object tag and age of the object, etc.

```
# 1. Run batch-expire.sh to setup bucket
# Modify the ALIAS to match your local naming convention
bash -x ./batch-expire.sh


# 2. Run batch-expire job
jobId=$(./mc batch start myminio ./expire.yaml --json | jq -r '.result.id') 
mc batch status myminio $jobId

# 3. (Optional) Monitor batch job using admin-trace
mc admin trace --call batch-expiration myminio | tee batch-expire-trace.1
```
