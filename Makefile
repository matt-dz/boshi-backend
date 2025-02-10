.PHONY: all run clean build help

include .env
export

BUILD_IMAGE_NAME ?= boshi-backend
BUILD_NAME = $(DOCKER_REGISTRY)/$(BUILD_IMAGE_NAME)

all: build

build:
	@echo "Building the application.."
	go build -o bin/boshi-backend cmd/main.go

run:
	@echo "Running the application.."
	go run cmd/main.go

docker-push:
	@echo "Pushing the docker image.."
	docker tag $(BUILD_IMAGE_NAME):latest $(BUILD_NAME):latest
	docker push $(BUILD_NAME):latest

docker:
	@echo "Building the docker image.."
	docker build -t $(BUILD_IMAGE_NAME):latest .

clean:
	rm bin/*

help:
	cat Makefile
