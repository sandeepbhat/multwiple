#!/bin/bash
set -e -x
APATH=`pwd`
SERVER=multwiple-server
echo Setting up server...
mkdir -p ${SERVER}
cd ${SERVER}; tar -zxvf ${APATH}/multwiple.server.tar.gz; cd db
echo Setting up database...
./restore.sh
cd ../..
echo Setting up static website...
cd /var/www/multwiple.com
rm -rf *
tar -zxvf ${APATH}/multwiple.static.tar.gz
cd -
echo multwiple.com: Installation complete.
