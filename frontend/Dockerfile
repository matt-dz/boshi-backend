FROM --platform=$BUILDPLATFORM ghcr.io/cirruslabs/flutter:3.27.3@sha256:62c4b64788487d78e511e87d3ff8c6d6967f2b8fb9bf508a894d22447d448678 AS build
WORKDIR /app
COPY . .
RUN flutter build web

FROM nginx:alpine
COPY --from=build /app/build/web /usr/share/nginx/html
