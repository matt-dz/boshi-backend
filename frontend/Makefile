.PHONY: docker docker-push

SHELL := /bin/bash

DOCKER_REGISTRY ?= matthew10125
IMAGE_NAME ?= boshi-frontend
TAG ?= latest
BUILD_NAME ?= $(DOCKER_REGISTRY)/$(IMAGE_NAME)
PLATFORM ?= linux/arm64

docker:
	@echo "Building $(BUILD_NAME)"
	host=$$(../scripts/generate-subdomain.sh).deguzman.cloud && \
        if [[ host == "main" ]]; then host="boshi.deguzman.cloud"; fi && \
		   docker buildx build --build-arg NGINX_HOST=$${host} --platform $(PLATFORM) -t $(BUILD_NAME) .

docker-push:
	@echo "Pushing $(BUILD_NAME):$(tag)"
	docker tag $(BUILD_NAME) $(BUILD_NAME):$(TAG)
	docker push $(BUILD_NAME):$(TAG)
