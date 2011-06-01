#!/bin/bash
set -e -x

PORT="8090"
LOGGING="--accessLoggerClassName=winstone.accesslog.SimpleAccessLogger"
WINSTONE="./config/winstone/winstone-0.9.10.jar"


trap "echo 'quitting on Ctrl-C'; kill 0; exit;" SIGINT
(java -jar ${WINSTONE} --httpPort=${PORT} -server --directoryListings=false ${LOGGING} ./build/server &)

./config/nginx/bin/nginx -p ./config/nginx/


kill 0
