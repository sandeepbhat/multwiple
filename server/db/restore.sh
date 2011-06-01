#!/bin/bash
set -e
FILE="multwipleDB"
EXTRA=
if [[ -n $1 ]] ; then
  FILE=$1
  EXTRA=" -d ${FILE} "
  echo "Using ${FILE}..."
fi
echo "Restoring" `date` >> restore.log
set -x
psql -h 127.0.0.1 -p 5432 -U postgres -X ${EXTRA} -f ${FILE}-schema.sql >> restore.log
psql -h 127.0.0.1 -p 5432 -U postgres -X ${EXTRA} -f ${FILE}-data.sql >> restore.log
 
