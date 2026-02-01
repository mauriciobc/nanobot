# nanobot - Ultra-Lightweight Personal AI Assistant
# Python 3.12 (compatible with 3.11+ from pyproject.toml)
FROM python:3.12-slim

WORKDIR /app

# Dependências de sistema para build nativo (lxml, tiktoken, fastuuid) + OpenSSH
RUN apt-get update && apt-get install -y --no-install-recommends \
    libxml2-dev \
    libxslt-dev \
    gcc \
    g++ \
    make \
    curl \
    openssh-server \
    python3-dev \
    && rm -rf /var/lib/apt/lists/* \
    && curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain stable \
    && . $HOME/.cargo/env

# Copiar e instalar nanobot
COPY pyproject.toml ./
COPY nanobot/ ./nanobot/
COPY bridge/ ./bridge/
COPY README.md LICENSE ./

ENV PATH="/root/.cargo/bin:${PATH}" \
    PIP_PREFER_BINARY=1 \
    CARGO_BUILD_JOBS=1
RUN pip install --no-cache-dir --prefer-binary .

# Entrypoint: SSH (opcional) + nanobot gateway
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

# Diretório de dados persistente (config, workspace, sessions)
# Monte um volume em /root/.nanobot ou defina HOME
ENV HOME=/root
VOLUME ["/root/.nanobot"]

# Gateway porta padrão | SSH porta 22 (mapeie 2222:22 no host)
EXPOSE 18789 22

# Variáveis opcionais: SSH_ROOT_PASSWORD (senha root), OPENSSH_ENABLED (1=sim)
ENTRYPOINT ["/docker-entrypoint.sh"]
