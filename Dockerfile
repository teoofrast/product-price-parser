FROM python:3.12-alpine

# Костыли для psycopg2 и lxml на alpine
RUN apk add --no-cache --virtual .build-deps \
    gcc \
    musl-dev \
    postgresql-dev \
    libxml2-dev \
    libxslt-dev \
    && apk add --no-cache libpq libxslt

COPY --from=ghcr.io/astral-sh/uv:latest /uv /bin/uv

WORKDIR /app
COPY pyproject.toml uv.lock ./
RUN uv sync --frozen --no-dev

# Удаляем билд-зависимости чтобы уменьшить образ
RUN apk del .build-deps

COPY . .

ENV PATH="/app/.venv/bin:$PATH"
CMD ["uvicorn", "presentation.api.main:app", "--host", "0.0.0.0", "--port", "8000"]