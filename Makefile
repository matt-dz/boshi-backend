.PHONY: all run clean build help

include .env
export

DEV ?= true
TAG ?= latest
IMAGE_NAME ?= $(shell if [ "$(DEV)" = "false" ]; then echo $(PROD_IMAGE_NAME); else echo $(DEV_IMAGE_NAME); fi)
BUILD_NAME ?= $(DOCKER_REGISTRY)/$(IMAGE_NAME)

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
	docker build -t $(BUILD_NAME) .

clean:
	@echo "Cleaning bin directory..."
	rm bin/*

help:
	cat Makefile
