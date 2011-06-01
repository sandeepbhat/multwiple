DBNAME:=aagentdb
SCHEMA:= aagentdb-schema.sql

all: ${SCHEMA}

${SCHEMA}:
	@echo "DROP DATABASE IF EXISTS '${DBNAME}';" > $@
	@mysqldump -u root -p ${DBNAME} >> $@
	@echo "GRANT ALL PRIVILEGES ON ${DBNAME}.* to ${DBNAME}_webuser@'localhost' IDENTIFIED BY 'yl4FUS456yD3FIghq';" >> $@

db: ${SCHEMA}
	mysql -u root -p < ${SCHEMA}


	