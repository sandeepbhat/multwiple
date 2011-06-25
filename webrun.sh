#!/bin/bash
set -e -x

PORT="8090"
LOGGING="--accessLoggerClassName=winstone.accesslog.SimpleAccessLogger"
WINSTONE="./config/winstone/winstone-0.9.10.jar"
TWIITER_LOGGING="-Dtwitter4j.loggerFactory=twitter4j.internal.logging.NullLoggerFactory"

trap "echo 'quitting on Ctrl-C'; kill 0; exit;" SIGINT
(java ${TWIITER_LOGGING} -jar ${WINSTONE} --httpPort=${PORT} -server --directoryListings=false ${LOGGING} ./build/server &)

./config/nginx/bin/nginx -p ./config/nginx/


kill 0
