LIST = \
	academicCV \
	professionnalCV \
	academicCV,coverLetter	

.PHONY: $(LIST)

all: $(LIST)

$(LIST):
	@printf "\n\n\n\n ============ %s ============ \n\n\n\n\n" "$@"
	@./setup.sh "$@"
	latexmk -pdflua -latexoption=-file-line-error -latexoption=-interaction=nonstopmode -output-directory="$@" -aux-directory="$@" -jobname="Jean-Philippe Legault" "$@/_main.tex"
