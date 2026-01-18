FROM python:3.11-slim-bookworm

# 1. CRITICAL: Force Python to print logs immediately (Disable buffering)
ENV PYTHONUNBUFFERED=1

# 2. Install uv
COPY --from=ghcr.io/astral-sh/uv:latest /uv /bin/uv

# 4. Set Workdir
WORKDIR /app

# 7. Copy Source Code
COPY main.py .
COPY pyproject.toml uv.lock README.md* ./

# 6. Install Dependencies
# We use --system because we are already in a container, no need for venv
RUN uv sync

# 8. Define the entrypoint
# We run Xvfb and then the Python daemon inside it
CMD ["python3", "main.py"]
