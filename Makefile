export LOG_LEVEL := $(findstring s,$(word 1, $(MAKEFLAGS)))
ARG = $(filter-out $@,$(MAKECMDGOALS))
TAG = $(if $(filter %,$(ARG)),$(ARG),8.2-apache-buster)

ifndef FRAMEWORK
FRAMEWORK = 4
endif

.PHONY: all build build-image new-test create-project install-project test-build-image test clean $(ARG)
all:
	@echo "Silverstripe Web - Docker image builder"
	@echo
	@echo "Basic Commands"
	@echo "  build <version>         Build Dockerfiles. Filter PHP using <version>."
	@echo "  update                  Update Dockerfiles using build/update.sh"
	@echo
	@echo "Test Commands"
	@echo "  new-test <tag>          Start a new test using <tag>, Default: 8.2-apache-buster."
	@echo "  test <tag>              Execute tests, assumes project has been build."
	@echo "  clean                   Delete all test data." 
	@echo
	@echo "Advanced Test Commands"
	@echo "  create-project <tag>    Create new Silverstripe Project".
	@echo
	@echo "Parameters"
	@echo "  <version>               PHP version. Format '<major>.<minor>'. e.g. '8.2'"
	@echo "  <tag>                   Tag to build/test. e.g. '8.2-apache-jessie'"

update:
	./build/update.sh $(ARG)

build:
	./build/build-regex.sh $(ARG)

build-image:
	./build/build-image.sh $(TAG)

new-test:
	@echo "Running new test"
	@echo "  Tag: $(TAG)"
	@echo "  BuildDir: src/$(subst -,/,$(TAG))"
	@echo
	@$(MAKE) --quiet clean
	@FRAMEWORK=$(FRAMEWORK) $(MAKE) --quiet create-project $(TAG)
	@$(MAKE) --quiet test $(TAG)

create-project:
	TAG=$(TAG) docker-compose run composer config -g platform.php $(firstword $(subst -, ,$(TAG)))
	TAG=$(TAG) docker-compose run composer config -g platform.ext-intl 1
	TAG=$(TAG) docker-compose run composer create-project silverstripe/installer . ^$(FRAMEWORK)

test:
	TAG=$(TAG) BUILD_DIR="src/$(subst -,/,$(TAG))" docker-compose run sut
	TAG=$(TAG) BUILD_DIR="src/$(subst -,/,$(TAG))" docker-compose down

clean:
	docker-compose down --volume
