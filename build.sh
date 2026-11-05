#!/bin/env bash

. .env
TAG_NAME="centos-min"

buildah build --tag ${REPO_NAME}:${TAG_NAME} -f Containerfile-min
