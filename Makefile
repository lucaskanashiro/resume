BASE_NAME = cv-lucas-kanashiro
BUILD_DIR = build
PDF_NAME = cv-lucas-kanashiro.pdf
COVER_PDF_NAME = cv-lucas-kanashiro-cover.pdf
CV_PLUS_COVER_PDF = cv-lucas-kanashiro-with-cover.pdf

PDFLATEX_OPTIONS = -halt-on-error -aux-directory=$(BUILD_DIR) -output-directory=$(BUILD_DIR)
LATEX     = latex
PDFLATEX  = xelatex $(PDFLATEX_OPTIONS)
BIBTEX    = biber
NO_COLORS = \def\placehodervariable{1}

pdf: $(BASE_NAME).pdf

cover: $(BASE_NAME)-cover.pdf $(BASE_NAME).pdf
	pdfunite $(BASE_NAME)-cover.pdf $(BASE_NAME).pdf $(CV_PLUS_COVER_PDF)
	rm -rf $(BASE_NAME)-cover.pdf $(BASE_NAME).pdf

cover-nocolors: $(BASE_NAME)-cover.pdf nocolors
	pdfunite $(BASE_NAME)-cover.pdf $(BASE_NAME).pdf $(CV_PLUS_COVER_PDF)
	rm -rf $(BASE_NAME)-cover.pdf $(BASE_NAME).pdf

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

$(BASE_NAME)-cover.pdf: cover-letter.tex
	mkdir -p $(BUILD_DIR)
	$(PDFLATEX) "$(NO_COLORS) \input{$<}"
	$(PDFLATEX) "$(NO_COLORS) \input{$<}"
	$(PDFLATEX) "$(NO_COLORS) \input{$<}"
	$(PDFLATEX) "$(NO_COLORS) \input{$<}"
	cp $(BUILD_DIR)/cover-letter.pdf $(COVER_PDF_NAME)

.PHONY: clean pdf nocolors cover check

clean:
	rm -rf build $(PDF_NAME) $(COVER_PDF_NAME) $(CV_PLUS_COVER_PDF)

check:
	aspell -t -l en -c cover-letter.tex
	aspell -t -l en -c $(BASE_NAME).tex
