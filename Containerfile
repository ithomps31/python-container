FROM quay.io/centos/centos:stream10-minimal

WORKDIR /home/jq

RUN microdnf install -y python3 && microdnf clean all

ENTRYPOINT ["/usr/bin/bash"]
