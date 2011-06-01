BUILD:= ../build
TARGET:= dist/com.spundhan.multwiple_admin.jar

all: ${TARGET}
	@echo ">> Server: compiled.".
	
${TARGET}:
	@ant dist
	
${BUILD}/WEB-INF/lib:
	@mkdir -p ${BUILD}/WEB-INF/lib

dist: all ${BUILD}/WEB-INF/lib
	@cp src/web.xml ${BUILD}/WEB-INF/
	@cp -R dist/*.jar ${BUILD}/WEB-INF/lib/
	@cp -R lib/*.jar ${BUILD}/WEB-INF/lib/
	@echo ">> Server: distributed."


clean: ${TARGET}
	@ant clean
	@rm -rf ${BUILD}/WEB-INF/*.jar
	@echo ">> Server: cleaned."
	
