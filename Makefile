clean:
	@for line in $$(cat .gitignore); do find . -name $$line | xargs -I{} rm {}; done; \
		echo "cleaned"

build:
	$(MAKE) clean
	latexmk -CF -gg -f -lualatex main.tex
