#!/bin/sh

for i in `docker ps -a | awk '{print $NF}' | grep postgresql-`
do
	docker start $i
done
