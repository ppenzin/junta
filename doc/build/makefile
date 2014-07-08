# Compile and preveiw settings
LATEXC=pdflatex
DOT=dot

all: design.pdf

design.pdf: ../src/design.tex configuration.png
	$(LATEXC) $< -o $@

%.png: ../src/graph/%.dot
	$(DOT) -o $@ -Tpng $^

clean:
	rm -f *.pdf *.png *.aux *.log

