#!/usr/bin/env bash

branch=$(git branch --show-current)

if [[ $branch == "main" ]]; then
	echo "boshi"
else
	echo "$(git branch --show-current | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g' | sed 's/--*/-/g' | sed -E 's/^-+|-+$$//g')-boshi"
fi
