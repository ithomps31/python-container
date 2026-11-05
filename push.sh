#!/bin/env bash

. .env

if [ "$#" -ne 1 ]; then
    echo "Tag name required as an argument"
    exit 1
fi

buildah push ${REPO_NAME}:$1
