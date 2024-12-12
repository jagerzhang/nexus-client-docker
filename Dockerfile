FROM ubuntu:22.04
RUN apt update && \
    apt install -y openssl curl

ARG NEXUS_VERSION=0.4.2

WORKDIR /nexus
ENV NEXUS_HOME=/nexus \
    PROVER_ID_FILE=$NEXUS_HOME/prover-id \
    NEXUS_VERSION=${NEXUS_VERSION}

COPY binary/${NEXUS_VERSION} /nexus

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

CMD ["./prover", "beta.orchestrator.nexus.xyz"]
