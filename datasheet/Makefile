REV=$(shell git describe --dirty --always)

PANDOC=pandoc
PFLAGS=-M "title=Little Free Radio Datasheet" -M "author=Grant Iraci" -M revision=$(REV)

PDFLATEX=pdflatex
TFLAGS=

SECTIONS=overview.rst ratings.rst connectors.rst interfacing.rst

all: pdf

datasheet.tex: $(SECTIONS) ../template.tex
	$(PANDOC) --template ../template.tex -o $@ $(PFLAGS) $(SECTIONS)

datasheet.pdf: datasheet.tex
	$(PDFLATEX) $(TFLAGS) $^

pdf: datasheet.pdf

clean:
	rm -f datasheet.aux datasheet.pdf datasheet.html datasheet.log datasheet.out datasheet.tex

.PHONY: all pdf clean
