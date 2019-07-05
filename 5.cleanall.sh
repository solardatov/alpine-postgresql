#!/bin/sh

for i in `ls postgresql-* | cut -d '-' -f 2`
do
        container_name=`echo $i | cut -d '.' -f 1-2`
        docker rm postgresql-$container_name
        docker image rm alpine/postgres:$i
done
docker image rm alpine-pgbase
