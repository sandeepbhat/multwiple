#!/bin/bash
DBNAME=multwipleDB
set -e
echo "DROP DATABASE \"${DBNAME}\";" > ${DBNAME}.sql
pg_dump -i -h 127.0.0.1 -p 5432 -U postgres --format=plain -C -v -f "${DBNAME}.tmp" "${DBNAME}"
cat ${DBNAME}.tmp >> ${DBNAME}.sql
rm -f ${DBNAME}.tmp

