.PHONY: all run docker-push docker clean build help

DOCKER_REGISTRY ?= matthew10125
PROD_IMAGE_NAME ?= boshi-backend
DEV_IMAGE_NAME ?= boshi-backend-dev

DEV ?= true
TAG ?= latest
IMAGE_NAME ?= $(shell if [ "$(DEV)" = "false" ]; then echo $(PROD_IMAGE_NAME); else echo $(DEV_IMAGE_NAME); fi)
BUILD_NAME ?= $(DOCKER_REGISTRY)/$(IMAGE_NAME)
PLATFORM ?= linux/arm64

all: build

build:
	@echo "Building the application..."
	go build -o bin/boshi-backend cmd/main.go

run:
	@echo "Running the application..."
	go run cmd/main.go

docker-push:
	@echo "Tagging $(BUILD_NAME):$(TAG)..."
	docker tag $(BUILD_NAME) $(BUILD_NAME):$(TAG)
	@echo "Pushing $(BUILD_NAME):$(TAG)..."
	docker push $(BUILD_NAME):$(TAG)

docker:
	@echo "Building $(BUILD_NAME)..."
	docker buildx build --platform $(PLATFORM) -t $(BUILD_NAME) .

clean:
	@echo "Cleaning bin directory..."
	rm bin/*

help:
	cat Makefile
