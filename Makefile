LIST = \
	academicCV \
	professionnalCV \
	academicCV,coverLetter	

.PHONY: $(LIST)

all: $(LIST)

$(LIST):
	@printf "\n\n\n\n ============ %s ============ \n\n\n\n\n" "$@"
	@./build.sh "$@"	
