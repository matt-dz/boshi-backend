# Generate client-metadata.json for OAuth2
FROM debian:bookworm as oauth
ARG SUBDOMAIN
WORKDIR /app
COPY scripts/generate-client-metadata.sh .
COPY configs/client-metadata-template.json .
RUN ./generate-client-metadata.sh client-metadata-template.json $SUBDOMAIN

# Build the Go application
FROM --platform=$BUILDPLATFORM golang:alpine as build
WORKDIR /app
COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=arm64 go build -o bin/boshi-backend cmd/main.go

# Build the final image
FROM alpine:latest
WORKDIR /app
COPY --from=build /app/bin/boshi-backend /app/boshi-backend
COPY --from=oauth /app/client-metadata.json /srv/client-metadata.json
ENV PORT=80
ENV SRV_DIR=/srv
EXPOSE 80
ENTRYPOINT ["/app/boshi-backend"]
