#!/bin/bash
rm -rf ${DBNAME}-schema.sql ${DBNAME}-data.sql
DBNAME="multwipleDB"
set -e
echo "DROP DATABASE \"${DBNAME}\";" > ${DBNAME}-schema.sql
pg_dump -i -h 127.0.0.1 -p 5432 -U postgres --format=plain -C -D -s -v -f ${DBNAME}.tmp ${DBNAME}
cat ${DBNAME}.tmp >> ${DBNAME}-schema.sql
rm -f ${DBNAME}.tmp
pg_dump -i -h 127.0.0.1 -p 5432 -U postgres --format=plain -C -D -a -v -f ${DBNAME}-data.sql ${DBNAME}

