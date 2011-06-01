#!/bin/bash
set -e -x

PORT="8090"
LOGGING="--accessLoggerClassName=winstone.accesslog.SimpleAccessLogger"
WINSTONE="./config/winstone/winstone-0.9.10.jar"

java -jar ${WINSTONE} --httpPort=${PORT} -server --directoryListings=false ${LOGGING} ./server 
