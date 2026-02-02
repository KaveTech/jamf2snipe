FROM python:3.11-slim

WORKDIR /app

# Install envsubst (part of gettext package)
RUN apt-get update && apt-get install -y gettext-base && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .

# Substitute environment variables in config file at runtime
CMD envsubst < settings.conf.example > settings.conf && python jamf2snipe.py