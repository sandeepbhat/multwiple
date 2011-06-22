#!/bin/bash
SQL=cleanMultwipleDB.sql
DB=multwipleDB
echo "Cleaning up DB..."
psql -q -h 127.0.0.1 -p 5432 -U postgres -d ${DB} -f ${SQL}
echo "DB Cleaned."

