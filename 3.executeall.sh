
#!/bin/sh

for i in `docker ps -a | awk '{print $NF}' | grep postgresql- | sort -t '-' -k 2 -n`
do
	echo "[$i]"
	docker exec -it -e PGUSER=postgres -e PGDATABASE=template1 $i "$@"
	echo "================================================================================"
done
