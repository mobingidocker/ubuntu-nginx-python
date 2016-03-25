#!/usr/bin/env bash

set -e

curl -H "Content-Type: application/json" --data "{\"source_type\": \"Branch\", \"source_name\": \"${CIRCLE_BRANCH}\"}" -X POST https://registry.hub.docker.com/u/mobingi/ubuntu-nginx-python/trigger/${DOCKERHUB_BUILD_TOKEN}/
