#!/bin/env bash

# ENV Vars
. .env
IMAGE_NAME="scratch"

# Scratch setup
python_container=$(buildah from scratch)
scratchmnt=$(buildah mount $python_container)

# Remove artifacts at exit
cleanup() {
    buildah umount "$python_container" >/dev/null 2>&1 || true
}
trap cleanup EXIT

# Install python3
dnf -y --installroot $scratchmnt \
    --disablerepo=* \
    --enablerepo=rhel-9-for-x86_64-baseos-rpms \
    --releasever 9 \
    --setopt install_weak_deps=false \
    --setopt=tsflags=nodocs \
    install python3

# Cache removal
dnf --installroot $scratchmnt clean all
rm -rf "$scratchmnt"/var/cache/dnf \
       "$scratchmnt"/var/log/dnf* \
       "$scratchmnt"/var/log/hawkey*


# Add example file and set entrypoint
# buildah copy $python_container ./${EX_FILE} /app/${EX_FILE}
buildah config --entrypoint '/usr/bin/bash' $python_container

# Save python image
buildah commit $python_container ${REPO_NAME}:${IMAGE_NAME}
