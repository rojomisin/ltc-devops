FROM debian:bullseye-slim

RUN useradd -s /bin/bash -m -U litecoin && \
    mkdir -p /var/app && \
    mkdir -p /var/app-data && \
    chown litecoin:litecoin /var/app* && \
    chmod 0755 /var/app* && \
    apt-get update && \
    apt-get install curl -y
USER litecoin:litecoin
WORKDIR /var/app

### artifacts
RUN curl -O -L -s https://download.litecoin.org/litecoin-0.18.1/linux/litecoin-0.18.1-x86_64-linux-gnu.tar.gz
RUN curl -O -L -s https://download.litecoin.org/litecoin-0.18.1/linux/litecoin-0.18.1-linux-signatures.asc

# checksum
RUN grep x86_64 litecoin-0.18.1-linux-signatures.asc >litecoin-checksum.sha256
RUN sha256sum -c litecoin-checksum.sha256 || exit 1

# unpack
RUN tar -xvzf litecoin-0.18.1-x86_64-linux-gnu.tar.gz

ENV PATH="/var/app/litecoin-0.18.1/bin:${PATH}"
VOLUME ["/var/app-data"]
ENTRYPOINT litecoind
CMD ["-printtoconsole", "-datadir=/var/app-data"]
