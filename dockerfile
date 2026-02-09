FROM python:3.10-slim

RUN apt-get update && apt-get install -y \
    git libopus-dev ffmpeg curl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . .

RUN pip install --no-cache-dir torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu
RUN pip install --no-cache-dir ./moshi/. accelerate

EXPOSE 8998

CMD ["python", "-m", "moshi.server", "--device", "cpu", "--cpu-offload"]
