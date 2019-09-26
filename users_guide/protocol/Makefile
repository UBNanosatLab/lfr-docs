REV=$(shell git describe --dirty --always)

PDFLATEX=pdflatex
TFLAGS=

PROTO=generic.png


all: png

protocol: $(PROTO_DEPS)

%.pdf: %.tex
	$(PDFLATEX) $^

%.png: %.pdf
	convert -density 100 $^ -quality 100 $@

png: $(PROTO)

clean:
	rm -f *.aux *.pdf *.out *.log

clean-all: clean
	rm -f *.png

.PHONY: all pdf clean clean-all
