#!/usr/bin/env bash

# This script generates the client-metadata.json file for OAuth2.0
cat $1 | sed "s|<URL>|${SUBDOMAIN}|g" > client-metadata.json
