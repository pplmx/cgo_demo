.PHONY: help static-c static-cpp build run run-c run-cpp exe-c exe-cpp clean
.DEFAULT_GOAL := help

# Variables
CC = gcc
CXX = g++

ifeq ($(shell uname -s),Darwin)
	CC = clang
	CXX = clang++
endif

# build static lib
# $(1): c or cpp
# $(2): CC or CXX
define build_static_lib
	@echo "===== compile static lib for $(1) ====="
	@$($(2)) -c lib/hi.$(1) -o lib/hi.o
	@ar rcs lib/libhi.a lib/hi.o
	@rm -fr lib/hi.o
endef

# build static lib for c
static-c:
	$(call build_static_lib,c,CC)

# build static lib for cpp
static-cpp:
	$(call build_static_lib,cpp,CXX)

# build go binary
build:
	@echo "===== build with c/c++ static lib ====="
	@go build -o bin/hi main.go

# run directly
run:
	@go run main.go

# run with c static lib
run-c: clean static-c
	@echo "===== go run with c static lib ====="
	@go run main.go

# run with cpp static lib
run-cpp: clean static-cpp
	@echo "===== go run with cpp static lib ====="
	@go run main.go

exe-c: clean static-c build
	@echo "===== run binary with c static lib ====="
	@./bin/hi

exe-cpp: clean static-cpp build
	@echo "===== run binary with cpp static lib ====="
	@./bin/hi

# clean all
clean:
	@echo "===== clean all ====="
	@rm -fr bin/hi lib/hi.o lib/libhi.a

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
