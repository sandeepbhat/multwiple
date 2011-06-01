BUILD:= ../build

all: 
	@echo ">> UI: compiled.".
	
dist: all 
	@mkdir -p ${BUILD}/scripts ${BUILD}/css ${BUILD}/images ${BUILD}/css/cupertino/images ${BUILD}/css/blueprint/src
	@mkdir -p ${BUILD}/charting/css ${BUILD}/charting/images ${BUILD}/charting/js
	
	@cp -R src/favicon.ico ${BUILD}/
	@cp -R src/admin.html ${BUILD}/
	@cp -R src/scripts/jquery-1.4.2.min.js ${BUILD}/scripts/
	@cp -R src/scripts/jquery-ui-1.7.2.custom.min.js ${BUILD}/scripts/
	@cp -R src/scripts/admin.js ${BUILD}/scripts/
	@cp -R src/scripts/json_parse.js ${BUILD}/scripts/
	@cp -R src/css/admin.css ${BUILD}/css/
	@cp -R src/css/cupertino/jquery-ui-1.7.2.custom.css ${BUILD}/css/cupertino
	@cp -R src/css/cupertino/images/*.* ${BUILD}/css/cupertino/images
	@cp -R src/css/blueprint/*.* ${BUILD}/css/blueprint/
	@cp -R src/css/blueprint/src/*.* ${BUILD}/css/blueprint/src/
	@cp -R src/images/*.* ${BUILD}/images/

	@cp -R src/charting/css/*.* ${BUILD}/charting/css/
	@cp -R src/charting/js/visualize.jQuery.js ${BUILD}/charting/js/
	@cp -R src/charting/images/*.png ${BUILD}/charting/images/
	
	
	@echo ">> UI: distributed."
	
clean: 
	@rm -rf ${BUILD}/*
	@echo ">> UI: cleaned."
	
 
