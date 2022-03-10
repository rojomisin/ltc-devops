FROM debian:bullseye-slim

# create a user
RUN groupadd litecoin && \
    useradd -m -g litecoin litecoin && \
    mkdir -p /home/litecoin/.litecoin && \
    chown litecoin:litecoin /home/litecoin/.litecoin && \
    apt-get update && \
    apt-get install curl -y
USER litecoin:litecoin
WORKDIR /home/litecoin

### get artifacts
RUN curl -O -L -s https://download.litecoin.org/litecoin-0.18.1/linux/litecoin-0.18.1-x86_64-linux-gnu.tar.gz
RUN curl -O -L -s https://download.litecoin.org/litecoin-0.18.1/linux/litecoin-0.18.1-linux-signatures.asc


# checksum
RUN grep x86_64 litecoin-0.18.1-linux-signatures.asc >litecoin-checksum.sha256

RUN sha256sum -c litecoin-checksum.sha256 || exit 1

# unpack
RUN tar -xvzf litecoin-0.18.1-x86_64-linux-gnu.tar.gz

RUN ls -alh
WORKDIR /home/litecoin/litecoin-0.18.1
VOLUME ["/home/litecoin/.litecoin"]
CMD ["/home/litecoin/litecoin-0.18.1/bin/litecoind", "-printtoconsole"]
