#!/bin/bash
set -e
DBNAME=multwipleDB
EXTRA=
if [[ -n $1  ]]; then
  FILE=$1
#  EXTRA=" -d ${DBNAME} "
else
  FILE=${DBNAME}.sql
fi
echo "Using ${FILE}..."
echo "Restoring" `date` >> restore.log
set -x
psql -h 127.0.0.1 -p 5432 -U postgres -X ${EXTRA} -f ${FILE} >> restore.log
./clean.sh
./seed.sh
