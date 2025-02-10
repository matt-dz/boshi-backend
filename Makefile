.PHONY: all run clean build help


all: build

build:
	@echo "Building the application.."
	go build -o bin/boshi-backend cmd/main.go

run:
	@echo "Running the application.."
	go run cmd/main.go

clean:
	rm bin/*

help:
	cat Makefile
