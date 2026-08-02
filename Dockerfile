FROM python:3.13-slim-bookworm

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PATH="/root/.deno/bin:${PATH}" \
    YTDLP_JS_RUNTIME=deno

RUN apt-get update \
    && apt-get install -y --no-install-recommends ffmpeg curl ca-certificates git unzip \
    && rm -rf /var/lib/apt/lists/* \
    && curl -fsSL https://deno.land/install.sh | sh

# Install the current featured PO-token provider alongside yt-dlp.
RUN git clone --depth 1 --branch 1.3.1 https://github.com/Brainicism/bgutil-ytdlp-pot-provider.git /root/bgutil-ytdlp-pot-provider \
    && cd /root/bgutil-ytdlp-pot-provider/server \
    && deno install --allow-scripts=npm:canvas --frozen

WORKDIR /app
COPY requirements.txt ./
RUN pip install --no-cache-dir -U pip \
    && pip install --no-cache-dir -r requirements.txt

COPY main.py ./main.py

# Start the local PO-token HTTP provider and then the Telegram bot.
CMD ["sh", "-c", "cd /root/bgutil-ytdlp-pot-provider/server/node_modules && deno run --allow-env --allow-net --allow-ffi=. --allow-read=. ../src/main.ts & exec python main.py"]
