FROM --platform=$BUILDPLATFORM ghcr.io/cirruslabs/flutter:stable AS build
WORKDIR /app
COPY . .
RUN flutter build web

FROM nginx:alpine
EXPOSE 80
COPY --from=build /app/build/web /usr/share/nginx/html
