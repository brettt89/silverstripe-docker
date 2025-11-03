export LOG_LEVEL := $(findstring s,$(word 1, $(MAKEFLAGS)))
ARG = $(filter-out $@,$(MAKECMDGOALS))

ifndef FRAMEWORK
FRAMEWORK = 5
endif

IMAGE_NAME		?= silverstripe-web
IMAGE_PREFIX 	?= brettt89
IMAGE_TAG		?= $(if $(filter %,$(ARG)),$(ARG),8.4-apache-bookworm)
COMMIT			?= commit-id
IMAGE			?= ${IMAGE_PREFIX}/${IMAGE_NAME}:${IMAGE_TAG}
BUILD_DIR       ?= src/$(subst -,/,$(IMAGE_TAG))

export IMAGE_NAME IMAGE_TAG COMMIT IMAGE BUILD_DIR

.PHONY: all build build-image new-test create-project test clean $(ARG)
all:
	@echo "Silverstripe Web - Docker image builder"
	@echo
	@echo "Basic Commands"
	@echo "  build <version>         Build Dockerfiles. Filter PHP using <version>."
	@echo "  update                  Update Dockerfiles using build/update.sh"
	@echo
	@echo "Test Commands"
	@echo "  new-test <tag>          Start a new test using <tag>, Default: 8.3-apache-bookworm."
	@echo "  test <tag>              Execute tests, assumes project has been build."
	@echo "  clean                   Delete all test data." 
	@echo
	@echo "Advanced Test Commands"
	@echo "  create-project <tag>    Create new Silverstripe Project".
	@echo
	@echo "Parameters"
	@echo "  <version>               PHP version. Format '<major>.<minor>'. e.g. '8.3'"
	@echo "  <tag>                   Tag to build/test. e.g. '8.3-apache-bookworm'"

update:
	./build/update.sh

build:
	./build/build-regex.sh $(if $(filter %,$(ARG)),$(ARG),8.4-apache-bookworm)

build-image:
	IMAGE_TAG=${IMAGE_TAG} ./build/build-image.sh

new-test:
	@echo "Running new test"
	@echo "  Tag: $(IMAGE_TAG)"
	@echo "  BuildDir: $(BUILD_DIR)"
	@echo
	@$(MAKE) --quiet clean
	@FRAMEWORK=$(FRAMEWORK) $(MAKE) --quiet create-project $(IMAGE_TAG)
	@$(MAKE) --quiet test $(IMAGE_TAG)

create-project:
	docker compose run --rm composer config -g platform.php $(firstword $(subst -, ,$(IMAGE_TAG)))
	docker compose run --rm composer config -g platform.ext-intl 1
	docker compose run --rm composer create-project silverstripe/installer . ^$(FRAMEWORK)

test:
	docker compose run sut
	docker compose down

clean:
	docker compose down --volumes
