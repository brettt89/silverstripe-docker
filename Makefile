export LOG_LEVEL := $(findstring s,$(word 1, $(MAKEFLAGS)))
ARG = $(filter-out $@,$(MAKECMDGOALS))
TAG = $(if $(filter %,$(ARG)),$(ARG),7.4-apache-buster)

ifndef FRAMEWORK
FRAMEWORK = 4
endif

.PHONY: all build build-image new-test create-project install-project test-build-image test clean $(ARG)
all:
	@echo "Silverstripe Web - Docker image builder"
	@echo
	@echo "Basic Commands"
	@echo "  build <regex>           Build and tag all images. Filter using <regex> on tag structure."
	@echo "  build-image <tag>       Build and tag specific image."
	@echo
	@echo "Test Commands"
	@echo "  new-test <tag>          Start a new test using <tag>, Default: 7.4-apache-buster."
	@echo "  test <tag>              Execute tests, assumes project has been build."
	@echo "  clean                   Delete all test data." 
	@echo
	@echo "Advanced Test Commands"
	@echo "  create-project <tag>    Create new Silverstripe Project".
	@echo "                            Environment variable FRAMEWORK=3 to change version"
	@echo "  install-project <tag>   Install project dependancies"
	@echo "  test-build-image <tag>  Test the image has been built locally"
	@echo "  build-test              Build 'sut' test image, used for running tests"
	@echo
	@echo "Parameters"
	@echo "  <regex>                 Regex for matching against tag. e.g. '7.4'"
	@echo "  <tag>                   Tag to build/test. e.g. '5.6-apache-jessie'"

build:
	./build/build-regex.sh $(ARG)

build-image:
	./build/build-image.sh $(TAG)

new-test:
	@echo "Running new test"
	@echo "  Tag: $(TAG)"
	@echo "  Build dir: $(subst -,/,$(subst -,/,$(TAG)))"
	@echo
	@$(MAKE) --quiet clean
	@BUILD_DIR=$(subst -,/,$(subst -,/,$(TAG))) $(MAKE) --quiet test-build-image $(TAG)
	@FRAMEWORK=$(FRAMEWORK) $(MAKE) --quiet create-project $(TAG)
	@$(MAKE) --quiet test $(TAG)

create-project:
	TAG=$(TAG) FRAMEWORK=$(FRAMEWORK) docker-compose run create-project

test-build-image:
	TAG=${TAG} docker-compose build

build-test:
	TAG=$(TAG) docker-compose build sut

test:
	TAG=$(TAG) docker-compose run sut

clean:
	docker-compose down --volume
