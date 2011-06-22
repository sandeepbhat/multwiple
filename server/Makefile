BUILD:= ../build/server
TARGET:= dist/com.spundhan.multwiple.jar

all: ${TARGET}
	@echo ">> Server: compiled.".
	
${TARGET}:
	@ant dist
	
${BUILD}/WEB-INF/lib:
	@mkdir -p ${BUILD}/WEB-INF/lib

dist: all ${BUILD}/WEB-INF/lib
ifdef DEBUG
	@sed 's|DEBUG|/s|' src/web.xml > ${BUILD}/WEB-INF/web.xml
else
	@sed 's|DEBUG||' src/web.xml > ${BUILD}/WEB-INF/web.xml
endif	
	@cp src/log4j.conf ${BUILD}/WEB-INF/
	@cp -R dist/*.jar ${BUILD}/WEB-INF/lib/
	@cp -R lib/*.jar ${BUILD}/WEB-INF/lib/
	@echo ">> Server: distributed."


clean:
	@ant clean
	@rm -rf ${BUILD}
	@echo ">> Server: cleaned."
	
 
