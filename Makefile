
all: hw1/hw1.pdf hw2/hw2.pdf

%.pdf: %.mkd
	pandoc -H preamble.tex -o $@ $<
