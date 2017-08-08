BASE_NAME = cv-athos-ribeiro
BUILD_DIR = build
PDF_NAME = cv-athos-ribeiro.pdf

PDFLATEX_OPTIONS = -halt-on-error -aux-directory=$(BUILD_DIR) -output-directory=$(BUILD_DIR)
LATEX     = latex
PDFLATEX  = xelatex $(PDFLATEX_OPTIONS)
BIBTEX    = biber

pdf: $(BASE_NAME).pdf

$(BASE_NAME).pdf: $(BASE_NAME).tex bibliography.bib friggeri-cv.cls
	mkdir -p $(BUILD_DIR)
	$(PDFLATEX) $<
	$(BIBTEX) $(BUILD_DIR)/$(BASE_NAME) 
	$(PDFLATEX) $< 
	$(PDFLATEX) $<
	$(PDFLATEX) $<
	cp $(BUILD_DIR)/$(BASE_NAME).pdf $(PDF_NAME)
	gnome-open $(PDF_NAME)

clean:
	rm -rf build $(PDF_NAME)
