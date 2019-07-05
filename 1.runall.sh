#!/bin/sh

docker build -f Dockerfile.pgbase -t alpine-pgbase .
for i in `ls postgresql-* | cut -d '-' -f 2`
do
	container_name=`echo $i | cut -d '.' -f 1-2`
	docker build -f Dockerfile.$i -t alpine/postgres:$i .
        docker run -d --name postgresql-$container_name alpine/postgres:$i
done
