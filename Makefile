BASE_NAME = cv-athos-ribeiro
BUILD_DIR = build
PDF_NAME = cv-athos-ribeiro.pdf

PDFLATEX_OPTIONS = -halt-on-error -aux-directory=$(BUILD_DIR) -output-directory=$(BUILD_DIR)
LATEX     = latex
PDFLATEX  = xelatex $(PDFLATEX_OPTIONS)
BIBTEX    = biber
NO_COLORS = \def\placehodervariable{1}

pdf: $(BASE_NAME).pdf

nocolors: NO_COLORS=\def\nocolors{1}
nocolors: pdf

$(BASE_NAME).pdf: $(BASE_NAME).tex bibliography.bib friggeri-cv.cls
	mkdir -p $(BUILD_DIR)
	$(PDFLATEX) "$(NO_COLORS) \input{$<}"
	$(BIBTEX) $(BUILD_DIR)/$(BASE_NAME) 
	$(PDFLATEX) "$(NO_COLORS) \input{$<}"
	$(PDFLATEX) "$(NO_COLORS) \input{$<}"
	$(PDFLATEX) "$(NO_COLORS) \input{$<}"
	cp $(BUILD_DIR)/$(BASE_NAME).pdf $(PDF_NAME)
	evince $(PDF_NAME)

.PHONY: clean pdf nocolors

clean:
	rm -rf build $(PDF_NAME)
