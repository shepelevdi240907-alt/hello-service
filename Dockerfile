# Общая база ----
FROM python:3.12-slim AS base

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

# Prod (по умолчанию) ----
FROM base AS prod

RUN pip install --no-cache-dir gunicorn uvicorn-worker

COPY main.py .

EXPOSE 8000

CMD ["gunicorn", "main:app", "--workers", "2", "--worker-class", "uvicorn_worker.UvicornWorker", "--bind", "0.0.0.0:8000"]

# Dev (автообновление кода) ----
FROM base AS dev

RUN pip install --no-cache-dir gunicorn uvicorn-worker

COPY main.py gunicorn-dev.py ./

EXPOSE 8000

CMD ["gunicorn", "main:app", "--config", "gunicorn-dev.py", "--worker-class", "uvicorn_worker.UvicornWorker", "--bind", "0.0.0.0:8000", "--reload"]
