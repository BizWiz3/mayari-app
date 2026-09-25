FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        curl \
        unzip \
        ca-certificates \
        libssl3 \
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