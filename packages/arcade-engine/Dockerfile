FROM ubuntu:latest
WORKDIR /usr/local/app

SHELL ["/bin/bash", "-c"]

ENV DEBIAN_FRONTEND=noninteractive

# Install the application dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    python3 \
    cmake \
    xz-utils \
    build-essential \
    jq \
    unzip \
    unzstd \
    && curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

# Install emsdk and ghc-wasm-meta
RUN git clone https://github.com/emscripten-core/emsdk.git \
    && cd emsdk \
    && ./emsdk install latest \
    && ./emsdk activate latest

RUN curl https://gitlab.haskell.org/haskell-wasm/ghc-wasm-meta/-/raw/master/bootstrap.sh | sh \
    && source ~/.ghc-wasm-meta/env \
    && ghc-wasm-meta install

ENV PATH="/root/.ghc-wasm/bin:${PATH}"

COPY . .
RUN source ./emsdk/emsdk_env.sh && source ~/.ghc-wasm-meta/env && npm run build