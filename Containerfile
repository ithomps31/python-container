FROM quay.io/centos/centos:stream10

WORKDIR /app/py

RUN dnf install -y python3 && dnf clean all && rm -rf /var/cache/dnf

ENTRYPOINT ["/usr/bin/bash"]
