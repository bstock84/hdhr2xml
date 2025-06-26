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

# Create output directory for EPG files
RUN mkdir -p /app/output

# Set the default command
ENTRYPOINT ["python", "HDHomeRunEPG_To_XmlTv.py"]

# Default command arguments (can be overridden)
CMD ["--help"]
