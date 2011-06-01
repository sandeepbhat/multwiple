BUILD:= ../../build/static
COMPRESS:=java -jar ../../tools/yuicompressor-2.4.2.jar
HTMLCOMPRESS:=java -jar ../../tools/htmlcompressor-0.9.1.jar --compress-css --compress-js --type html
all: 
	@echo ">> UI: compiled.".
	

	
	
dist: all 
	@mkdir -p ${BUILD}/scripts ${BUILD}/css ${BUILD}/images ${BUILD}/css/cupertino/images ${BUILD}/css/blueprint/src
	@cp -R src/favicon.ico ${BUILD}/
	@cp -R src/scripts/jquery-1.4.2.min.js ${BUILD}/scripts/
#	@cp -R src/scripts/jquery.getParams.js ${BUILD}/scripts/
	@cp -R src/scripts/jquery-ui-1.7.2.custom.min.js ${BUILD}/scripts/
	@cp -R src/scripts/s3Slider.js ${BUILD}/scripts/
	@cp -R src/scripts/index.js ${BUILD}/scripts/
	cat src/scripts/json_parse.js > ${BUILD}/scripts/tmp_compressed.js
	cat src/scripts/init.js >> ${BUILD}/scripts/tmp_compressed.js
	cat src/scripts/login.js >> ${BUILD}/scripts/tmp_compressed.js
	cat src/scripts/tweets.js >> ${BUILD}/scripts/tmp_compressed.js
	
ifdef DEBUG	
	@cp src/index.html ${BUILD}/
	@cp src/about.html ${BUILD}/
	@cp src/features.html ${BUILD}/
	@cp src/screenshots.html ${BUILD}/
	@cp src/terms.html ${BUILD}/
	@cp src/login.html ${BUILD}/
	@cp src/open_source.html ${BUILD}/
	@cp src/mapsPhotosPlugin.html ${BUILD}/
	cp ${BUILD}/scripts/tmp_compressed.js ${BUILD}/scripts/compressed.js
	@cp src/css/default.css ${BUILD}/css/
	@cp src/css/slider.css ${BUILD}/css/
	@cp src/css/cupertino/jquery-ui-1.7.2.custom.css ${BUILD}/css/cupertino
else
	${HTMLCOMPRESS} src/index.html -o ${BUILD}/index.html
	${HTMLCOMPRESS} src/about.html -o ${BUILD}/about.html
	${HTMLCOMPRESS} src/features.html -o ${BUILD}/features.html
	${HTMLCOMPRESS} src/screenshots.html -o ${BUILD}/screenshots.html
	${HTMLCOMPRESS} src/terms.html -o ${BUILD}/terms.html
	${HTMLCOMPRESS} src/login.html -o ${BUILD}/login.html
	${COMPRESS} ${BUILD}/scripts/tmp_compressed.js > ${BUILD}/scripts/compressed.js
	${COMPRESS} src/css/default.css > ${BUILD}/css/default.css
	${COMPRESS} src/css/slider.css > ${BUILD}/css/slider.css
	${COMPRESS} src/css/cupertino/jquery-ui-1.7.2.custom.css > ${BUILD}/css/cupertino/jquery-ui-1.7.2.custom.css
endif
	rm ${BUILD}/scripts/tmp_compressed.js
	@cp -R src/css/cupertino/images/*.* ${BUILD}/css/cupertino/images
	@cp -R src/css/blueprint/*.* ${BUILD}/css/blueprint/
	@cp -R src/css/blueprint/src/*.* ${BUILD}/css/blueprint/src/
	@cp -R src/images/*.* ${BUILD}/images/
	@echo ">> UI: distributed."


clean: 
	@rm -rf ${BUILD}
	@echo ">> UI: cleaned."
	
 
