FROM --platform=$BUILDPLATFORM golang:alpine as build
WORKDIR /app
COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=arm64 go build -o bin/boshi-backend cmd/main.go

FROM alpine:latest
WORKDIR /app
COPY --from=build /app/bin/boshi-backend /app/boshi-backend
COPY --from=build /app/client-metadata.json /srv/client-metadata.json
ENV PORT=80
ENV SRV_DIR=/srv
EXPOSE 80
ENTRYPOINT ["/app/boshi-backend"]
