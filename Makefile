
DOCKER_USER=greycubesgav
DOCKER_IMAGE_NAME=slackware-docker-base
DOCKER_PLATFORM=linux/amd64
BASE_VERSION?=15.0
BASE_IMAGE?=aclemons/slackware:$(BASE_VERSION)
DATE=$(shell date +%Y.%m.%d-%H%M%S)
DOCKER_IMAGE_VERSION?=aclemons-15.0
# Add NOCACHE='--no-cache' to force a rebuild
# e.g make NOCACHE='--no-cache' docker-image-build-aclemons-15
NOCACHE=

all: docker-image-build-aclemons-15 docker-image-build-aclemons-current

#----------------------------------------------------------------------------------------------------
# Build Docker image
#----------------------------------------------------------------------------------------------------

docker-image-build-vbatts-15:
	$(MAKE) docker-image-build BASE_IMAGE="vbatts" BASE_VERSION="15.0"

docker-image-build-aclemons-15:
	$(MAKE) docker-image-build BASE_IMAGE="aclemons" BASE_VERSION="15.0"

docker-image-build-aclemons-current:
	$(MAKE) docker-image-build BASE_IMAGE="aclemons" BASE_VERSION="current"

docker-image-build:
	$(eval DOCKER_FULL_IMAGE_NAME=$(DOCKER_USER)/$(DOCKER_IMAGE_NAME):$(BASE_IMAGE)-$(BASE_VERSION))
	@echo "Building $(DOCKER_FULL_IMAGE_NAME) against $(BASE_IMAGE)"
	docker build \
		$(NOCACHE) \
		--build-arg BASE_IMAGE="$(BASE_IMAGE)/slackware" --build-arg BASE_VERSION=$(BASE_VERSION) --platform $(DOCKER_PLATFORM) --file Dockerfile --tag $(DOCKER_FULL_IMAGE_NAME) .

#----------------------------------------------------------------------------------------------------
# Run Docker image
#----------------------------------------------------------------------------------------------------

docker-image-run-vbatts-15:
	$(MAKE) docker-image-run BASE_IMAGE="vbatts" BASE_VERSION="15.0"

docker-image-run-aclemons-15:
	$(MAKE) docker-image-run BASE_IMAGE="aclemons" BASE_VERSION="15.0"

docker-image-run-aclemons-current:
	$(MAKE) docker-image-run BASE_IMAGE="aclemons" BASE_VERSION="current"

docker-image-run:
	$(eval DOCKER_FULL_IMAGE_NAME=$(DOCKER_USER)/$(DOCKER_IMAGE_NAME):$(BASE_IMAGE)-$(BASE_VERSION))
	@echo "Running $(DOCKER_FULL_IMAGE_NAME)"
	docker run -it --rm $(DOCKER_FULL_IMAGE_NAME)

#----------------------------------------------------------------------------------------------------
# Push Docker image to Docker Hub
#----------------------------------------------------------------------------------------------------

docker-push-vbatts-15:
	$(MAKE) docker-push BASE_IMAGE="vbatts" BASE_VERSION="15.0"

docker-push-aclemons-15:
	$(MAKE) docker-push BASE_IMAGE="aclemons" BASE_VERSION="15.0"

docker-push-aclemons-current:
	$(MAKE) docker-push BASE_IMAGE="aclemons" BASE_VERSION="current"

docker-push:
	$(eval DOCKER_FULL_IMAGE_NAME=$(DOCKER_USER)/$(DOCKER_IMAGE_NAME):$(BASE_IMAGE)-$(BASE_VERSION))
	@echo "Pushing $(DOCKER_FULL_IMAGE_NAME)"
	docker push $(DOCKER_FULL_IMAGE_NAME)

#----------------------------------------------------------------------------------------------------
# Support targets
#----------------------------------------------------------------------------------------------------

docker-login:
	docker login