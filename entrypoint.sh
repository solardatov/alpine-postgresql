#!/bin/sh

if [ -f $PGDATA/PG_VERSION ]; then
  exec su postgres -c postmaster
else
  exec su postgres -c "initdb $*" && exec su postgres -c postmaster
fi
