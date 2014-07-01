# System settings
UNAME=$(shell uname)
ARCH=$(shell uname -m)
ifeq ($(UNAME), FreeBSD)
        OS=freebsd
	VIEWER=mupdf
else
ifeq ($(UNAME), Linux)
        OS=linux
	VIEWER=evince
else
        OS=unsupported
	VIEWER=unsupported
	ARCH=unsupported
endif
endif

# Compile and preveiw settings
LATEXC=pdflatex
DOT=dot

default: design

design: src/design.tex configuration.png
	$(LATEXC) $^

%.png: src/img/%.dot
	$(DOT) -o $@ -Tpng $^

clean:
	rm -f *.pdf *.png

preview: $(FILE)
	$(VIEWER) $^ &
