.PHONY: help
.DEFAULT_GOAL := help

# build static lib for c
static-c:
	@echo "===== build static lib for c ====="
	@gcc -c lib/hi.c -o lib/hi.o
	@ar rcs lib/libhi.a lib/hi.o
	@rm -fr lib/hi.o

# build static lib for cpp
static-cpp:
	@echo "===== build static lib for cpp ====="
	@g++ -c lib/hi.cpp -o lib/hi.o
	@ar rcs lib/libhi.a lib/hi.o
	@rm -fr lib/hi.o

# build go binary
build:
	@echo "===== build go binary ====="
	@go build -o bin/hi main.go

# run directly
run:
	@go run main.go

# Show help
help:
	@echo ""
	@echo "Usage:"
	@echo "    make [target]"
	@echo ""
	@echo "Targets:"
	@awk '/^[a-zA-Z\-_0-9]+:/ \
	{ \
		helpMessage = match(lastLine, /^# (.*)/); \
		if (helpMessage) { \
			helpCommand = substr($$1, 0, index($$1, ":")-1); \
			helpMessage = substr(lastLine, RSTART + 2, RLENGTH); \
			printf "\033[36m%-22s\033[0m %s\n", helpCommand,helpMessage; \
		} \
	} { lastLine = $$0 }' $(MAKEFILE_LIST)
