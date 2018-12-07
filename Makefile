HTML_PAGE = page.html
BUNDLED = bundle.js

OUTDIR = output
JS_OUTDIR = $(OUTDIR)/js
PAGE_PATH = $(OUTDIR)/$(HTML_PAGE)

PYRET_OUTPUT = .pyret

SERVER = http://localhost:$(PORT)
PORT = 8080

BROWSER = firefox

MAIN = src/main.arr
OUT_MAIN = .pyret/compiled/project/src/main.arr.js

run: build
	$(BROWSER) $(SERVER)/$(HTML_PAGE)
	
.PHONY: server
server:
	http-server $(OUTDIR)

build: setup pyret
	browserify "$(OUT_MAIN)" -o $(JS_OUTDIR)/$(BUNDLED)

pyret:
	anchor $(MAIN) -c

setup:
	mkdir -p $(OUTDIR)
	cp $(HTML_PAGE) $(OUTDIR)/$(HTMLPAGE)

.PHONY: clean
clean: 
	rm -r $(OUTDIR)
	rm -r $(PYRET_OUTPUT)
