PORT:= 9090
LOGGING:= --accessLoggerClassName=winstone.accesslog.SimpleAccessLogger
WINSTONE:=../config/winstone/winstone-0.9.10.jar

TARGET:= .dummy
DIST:=dist/com.spundhan.multwiple_admin.war

all: ${TARGET}	
	@echo ">> Multwiple Admin: done."

${TARGET}: 
	make -C ui
	make -C server
	@touch .dummy
	
run: dist
	java -jar ${WINSTONE} --httpPort=${PORT} -server --directoryListings=false ${LOGGING} --warfile=${DIST}
	
dist: all 
	make -C server dist
	make -C ui dist
	cd build/;	jar cf ../${DIST} * 
	
clean:
	make -C server clean
	make -C ui clean
	rm -rf ${TARGET} ${DIST}
