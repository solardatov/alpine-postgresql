
#!/bin/sh

for i in `docker ps -a | awk '{print $NF}' | grep postgresql- | sort`
do
	echo "[$i]"
	docker exec -it -e PGUSER=postgres -e PGDATABASE=template1 $i "$@"
	echo "================================================================================"
done
