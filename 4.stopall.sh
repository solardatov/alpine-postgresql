#!/bin/sh

for i in `docker ps -a | awk '{print $NF}' | grep postgresql-`
do
	echo "fast stop $i"
	docker exec -it $i kill -INT 1
done
