FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN sed -i 's|http://.*\.ubuntu\.com/ubuntu|http://us.archive.ubuntu.com/ubuntu|g' /etc/apt/sources.list.d/ubuntu.sources && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        curl \
        unzip \
        ca-certificates \
        libssl3 \
        libdbus-1-3 \
        libstdc++6 \
        git && \
    rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://mayari-org.github.io/docs/install-ember.sh | sh

ENV PATH="/root/.ember/bin:${PATH}"
ENV EMBER_CONFIG_USER_TOKEN_STORE=file
ENV PORT=8080

WORKDIR /mayari-app

COPY ember.toml ./
RUN embr install

COPY . .

EXPOSE 8080

CMD ["sh", "-c", "embr build && exec embr start"]