
DOCKER_USER=greycubesgav
DOCKER_IMAGE_NAME=slackware-docker-base
DOCKER_PLATFORM=linux/amd64
BASE_VERSION=15.0
BASE_IMAGE=vbatts/slackware:$(BASE_VERSION)
DATE=$(shell date +%Y.%m.%d-%H%M%S)
DOCKER_IMAGE_VERSION=$(BASE_VERSION)-$(DATE)

all: docker-image-build

docker-image-build:
	docker build --build-arg BASE_IMAGE=$(BASE_IMAGE) --platform $(DOCKER_PLATFORM) --file Dockerfile \
	--tag $(DOCKER_USER)/$(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_VERSION) \
	--tag $(DOCKER_USER)/$(DOCKER_IMAGE_NAME):latest .

docker-image-run:
	docker run -it --rm $(DOCKER_USER)/$(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_VERSION)

docker-push-latest:
	docker push $(DOCKER_USER)/$(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_VERSION)
	docker push $(DOCKER_USER)/$(DOCKER_IMAGE_NAME):latest

docker-push-version:
	docker push $(DOCKER_USER)/$(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_VERSION)

docker-login:
	docker login