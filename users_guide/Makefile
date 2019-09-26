REV=$(shell git describe --dirty --always)

PANDOC=pandoc
PFLAGS=-M "title=Little Free Radio User's Guide" -M "author=Grant Iraci" -M revision=$(REV)

PDFLATEX=pdflatex
TFLAGS=

SECTIONS=overview.rst protocol.rst

all: pdf

users_guide.tex: $(SECTIONS) ../template.tex
	$(PANDOC) --template ../template.tex -o $@ $(PFLAGS) $(SECTIONS)

users_guide.pdf: users_guide.tex protocol
	$(PDFLATEX) $(TFLAGS) $^
	# Run twice to generate updated TOC
	$(PDFLATEX) $(TFLAGS) $^

pdf: users_guide.pdf

protocol:
	$(MAKE) -C $@

clean:
	rm -f users_guide.aux users_guide.pdf users_guide.html users_guide.log users_guide.out users_guide.tex users_guide.toc
	rm -f protocol/*.aux protocol/*.pdf protocol/*.out protocol/*.log
	make -C protocol clean

.PHONY: all pdf clean protocol
