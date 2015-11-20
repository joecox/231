
all: hw1/hw1.pdf hw2/hw2.pdf hw3/hw3.pdf hw4/hw4.pdf hw5/hw5.pdf

%.pdf: %.mkd preamble.tex
	pandoc -H preamble.tex -o $@ $<

%.pdf: %.markdown preamble.tex
	pandoc -H preamble.tex -o $@ $<
