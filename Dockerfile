FROM python:3.11-slim

WORKDIR /app

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        nodejs \
        npm \
        build-essential \
        curl \
        dos2unix \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY . /app

RUN dos2unix start.sh 2>/dev/null || true && \
    chmod +x start.sh

RUN python3 -m venv venv

RUN /app/venv/bin/pip install --upgrade pip && \
    /app/venv/bin/pip install -r python_api/requirements.txt && \
    /app/venv/bin/pip install pybind11

WORKDIR /app/python_api
RUN /app/venv/bin/python setup.py install
WORKDIR /app

WORKDIR /app/react_dashboard
RUN if [ -f package.json ]; then \
        npm install && \
        npm run build; \
    fi
WORKDIR /app

ENV PATH="/app/venv/bin:$PATH"
ENV PYTHONUNBUFFERED=1

EXPOSE 5000

CMD ["bash", "start.sh"]