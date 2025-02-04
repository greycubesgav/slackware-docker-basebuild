
DOCKER_USER=greycubesgav
DOCKER_IMAGE_NAME=slackware-docker-base
DOCKER_PLATFORM=linux/amd64
DOCKER_IMAGE_VERSION=$(shell date +%Y.%m.%d)

all: docker-image-build

docker-image-build:
	docker build --platform $(DOCKER_PLATFORM) --file Dockerfile \
	--tag $(DOCKER_USER)/$(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_VERSION) \
	--tag $(DOCKER_USER)/$(DOCKER_IMAGE_NAME):latest .

docker-push-latest:
	docker push $(DOCKER_USER)/$(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_VERSION)
	docker push $(DOCKER_USER)/$(DOCKER_IMAGE_NAME):latest

docker-push-version:
	docker push $(DOCKER_USER)/$(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_VERSION)

docker-login:
	docker login