#!/bin/bash
SQL=seed.sql
DB=multwipleDB
echo ">> Adding seed data."
psql -q -h 127.0.0.1 -p 5432 -U postgres -d ${DB} -f ${SQL}
echo ">> Done adding seeding data."

