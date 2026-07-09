FROM ubuntu:22.04

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends \
       curl \
       git \
       jq \
       libicu70 \
       ca-certificates \
       apt-transport-https \
       lsb-release \
       gnupg \
    && rm -rf /var/lib/apt/lists/*

# Docker CLI, so pipeline steps can build/push images using the host's Docker daemon
RUN curl -fsSL https://get.docker.com | sh

WORKDIR /azp

COPY start.sh .
RUN chmod +x start.sh

RUN groupadd -g 1001 agentgroup \
    && useradd -m -u 1001 -g agentgroup agentuser \
    && chown -R agentuser:agentgroup /azp

USER agentuser

ENTRYPOINT ["./start.sh"]
