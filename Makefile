SRC=main.tex
build_type := academicCV professionnalCV

all: $(build_type)

$(build_type):
	echo "\def\$@{}\input{$(SRC)}" > $@.tex;\
	latexmk -gg -f -lualatex $@.tex;\
	rm $$(echo $@.* | sed 's/$@.pdf//g')
	# remove all but the pdf

