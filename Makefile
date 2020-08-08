export LOG_LEVEL := $(findstring s,$(word 1, $(MAKEFLAGS)))
ARG=$(filter-out $@,$(MAKECMDGOALS))

.PHONY: all build clean $(ARG)
all:
	@echo "Silverstripe Web - Docker image"
	@echo
	@echo "Basic Commands"
	@echo "  build <regex>    Build and tag all images. Filter using <regex> on tag structure."
	@echo "                     e.g. "7.4" for php7.4 builds, or "buster" for all buster builds."
	@echo "  clean            Delete all image tags / cache using." 
	@echo

build:
	@./build.sh $(filter-out $@,$(MAKECMDGOALS))

clean:
	@docker rmi $(docker images | grep 'silversripe-web') $a