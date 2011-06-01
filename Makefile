TARGET:= .dummy
DIST_ALL:=dist/multwiple.install.tgz
DIST_SERVER:=dist/multwiple.server.tar.gz
DIST_STATIC:=dist/multwiple.static.tar.gz
all: ${TARGET}	
	@echo ">> Multwiple: done."

${TARGET}: 
	make -C apps/web
	make -C apps/mobile-web
	make -C server
	@touch .dummy
	
webrun: webdist config/nginx/logs/access.log
	./webrun.sh
	
webdist: all 
	rm -rf tmp   
	rm -rf ${DIST_SERVER} ${DIST_STATIC}
	make -C server dist
	make -C apps/web dist
	@cd build/static; tar zcf ../../${DIST_STATIC} *
	mkdir -p tmp
	cp -R build/server tmp
	git archive master config | tar -x -C tmp/
	git archive master db | tar -x -C tmp/
	cp dist/run.sh tmp/
	@cd tmp; tar zcf ../${DIST_SERVER} server config db run.sh
	tar -zcvf ${DIST_ALL} ${DIST_SERVER} ${DIST_STATIC} dist/install.sh

config/nginx/logs/access.log:
	mkdir -p config/nginx/logs
	touch config/nginx/logs/access.log

mwebrun: mwebdist 
	./webrun.sh
	
mwebdist: all 
	rm -rf tmp   
	rm -rf ${DIST_SERVER} ${DIST_STATIC}
	make -C server dist
	make -C apps/mobile-web dist
	@cd build/static; tar zcf ../../${DIST_STATIC} *
	mkdir -p tmp
	cp -R build/server tmp
	git archive master config | tar -x -C tmp/
	git archive master db | tar -x -C tmp/
	cp dist/run.sh tmp/
	@cd tmp; tar zcf ../${DIST_SERVER} server config db run.sh
	tar -zcvf ${DIST_ALL} ${DIST_SERVER} ${DIST_STATIC} dist/install.sh
	
	
clean:
	make -C server clean
	make -C apps/web clean
	make -C apps/mobile-web clean
	rm -rf ${TARGET} ${DIST_ALL}


	
