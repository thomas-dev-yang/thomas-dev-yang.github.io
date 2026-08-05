PANDOC ?= pandoc
UV ?= uv
HOST ?= 127.0.0.1
PORT ?= 8000

CONTENT_DIR := content
OUTPUT_DIR := public
TEMPLATE := templates/page.html
STYLESHEET := assets/style.css
SCRIPT := assets/site.js
FAVICON_LIGHT := assets/favicon-light.svg
FAVICON_DARK := assets/favicon-dark.svg
PANDOC_DEFAULTS := pandoc.yaml
INDEX_FILTER := filters/post-links.lua
VENV_PYTHON := .venv/bin/python

PAGE_SOURCES := $(filter-out $(CONTENT_DIR)/index.md,$(shell find $(CONTENT_DIR) -type f -name '*.md' | sort))
PAGE_OUTPUTS := $(patsubst $(CONTENT_DIR)/%.md,$(OUTPUT_DIR)/%.html,$(PAGE_SOURCES))

.PHONY: all build clean rebuild serve

all: build

build: $(OUTPUT_DIR)/index.html $(PAGE_OUTPUTS) $(OUTPUT_DIR)/style.css $(OUTPUT_DIR)/site.js $(OUTPUT_DIR)/favicon-light.svg $(OUTPUT_DIR)/favicon-dark.svg

rebuild:
	$(MAKE) clean
	$(MAKE) build

$(OUTPUT_DIR)/index.html: $(CONTENT_DIR)/index.md $(PAGE_SOURCES) $(TEMPLATE) $(PANDOC_DEFAULTS) $(INDEX_FILTER)
	@mkdir -p $(@D)
	$(PANDOC) --defaults=$(PANDOC_DEFAULTS) \
		--from=markdown+wikilinks_title_after_pipe \
		--section-divs \
		--lua-filter=$(INDEX_FILTER) \
		--metadata=css-path:style.css \
		--metadata=script-path:site.js \
		--metadata=favicon-light-path:favicon-light.svg \
		--metadata=favicon-dark-path:favicon-dark.svg \
		--metadata=home-path:index.html \
		--metadata=is-home:true \
		--output=$@ $<

$(OUTPUT_DIR)/%.html: $(CONTENT_DIR)/%.md $(TEMPLATE) $(PANDOC_DEFAULTS)
	@mkdir -p $(@D)
	@relative_root="$$(realpath --relative-to="$(@D)" "$(OUTPUT_DIR)")"; \
	$(PANDOC) --defaults=$(PANDOC_DEFAULTS) \
		--metadata=css-path:"$$relative_root/style.css" \
		--metadata=script-path:"$$relative_root/site.js" \
		--metadata=favicon-light-path:"$$relative_root/favicon-light.svg" \
		--metadata=favicon-dark-path:"$$relative_root/favicon-dark.svg" \
		--metadata=home-path:"$$relative_root/index.html" \
		--output=$@ $<

$(OUTPUT_DIR)/style.css: $(STYLESHEET)
	@mkdir -p $(@D)
	cp $< $@

$(OUTPUT_DIR)/site.js: $(SCRIPT)
	@mkdir -p $(@D)
	cp $< $@

$(OUTPUT_DIR)/favicon-light.svg: $(FAVICON_LIGHT)
	@mkdir -p $(@D)
	cp $< $@

$(OUTPUT_DIR)/favicon-dark.svg: $(FAVICON_DARK)
	@mkdir -p $(@D)
	cp $< $@

$(VENV_PYTHON):
	$(UV) venv .venv

serve: $(VENV_PYTHON)
	@test -f $(OUTPUT_DIR)/index.html || \
		{ echo "No built site found. Run ./build first."; exit 1; }
	$(VENV_PYTHON) -m http.server $(PORT) --bind $(HOST) --directory $(OUTPUT_DIR)

clean:
	rm -rf $(OUTPUT_DIR)
