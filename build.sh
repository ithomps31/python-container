#!/bin/env bash

. .env
TAG_NAME="centos-10"

buildah build --tag ${REPO_NAME}:${TAG_NAME} -f Containerfile
