# Use Python 3.11 slim image as base
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Set environment variables
ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1

# Install system dependencies
RUN apt-get update && apt-get install -y \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements first to leverage Docker cache
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the Python script
COPY HDHomeRunEPG_To_XmlTv.py .

# Copy entrypoint script
COPY entrypoint.sh .

# Create output directory for EPG files
RUN mkdir -p /app/output

# Set entrypoint script as executable
RUN chmod +x entrypoint.sh

# Set the entrypoint to the entrypoint script
ENTRYPOINT ["./entrypoint.sh"]

# Default command arguments (can be overridden)
CMD ["--help"]
