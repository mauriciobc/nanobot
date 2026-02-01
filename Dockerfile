# nanobot - Ultra-Lightweight Personal AI Assistant
# Python 3.12 (compatible with 3.11+ from pyproject.toml)
FROM python:3.12-slim

WORKDIR /app

# Dependências de sistema mínimas (readability-lxml usa lxml)
RUN apt-get update && apt-get install -y --no-install-recommends \
    libxml2-dev \
    libxslt-dev \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Copiar e instalar nanobot
COPY pyproject.toml ./
COPY nanobot/ ./nanobot/
COPY bridge/ ./bridge/
COPY README.md LICENSE ./

RUN pip install --no-cache-dir .

# Diretório de dados persistente (config, workspace, sessions)
# Monte um volume em /root/.nanobot ou defina HOME
ENV HOME=/root
VOLUME ["/root/.nanobot"]

# Gateway porta padrão
EXPOSE 18789

ENTRYPOINT ["nanobot"]
CMD ["gateway", "--port", "18789"]
