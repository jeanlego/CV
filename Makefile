clean:
	@for line in $$(cat .gitignore); do find . -name $$line | xargs -I{} rm {}; done; \
		echo "cleaned"

build:
	$(MAKE) clean
	latexmk -gg -f -xelatex JeanPhilippeLegault.tex
