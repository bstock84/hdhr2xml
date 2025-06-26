# Docker Usage for HDHomeRun EPG to XMLTV

This project includes Docker support for easy deployment and execution.

## Quick Start

### Using Docker Compose (Recommended)

1. **Build and run with default settings:**
   ```bash
   docker-compose up --build
   ```

2. **Run in background:**
   ```bash
   docker-compose up -d --build
   ```

3. **View logs:**
   ```bash
   docker-compose logs -f
   ```

4. **Stop the container:**
   ```bash
   docker-compose down
   ```

### Using Docker directly

1. **Build the image:**
   ```bash
   docker build -t hdhomerun-epg .
   ```

2. **Run with default parameters:**
   ```bash
   docker run --rm --network host -v $(pwd)/output:/app/output hdhomerun-epg --filename /app/output/epg.xml
   ```

3. **Run with custom parameters:**
   ```bash
   docker run --rm --network host -v $(pwd)/output:/app/output hdhomerun-epg \
     --host 192.168.1.100 \
     --filename /app/output/custom-epg.xml \
     --days 5 \
     --hours 6 \
     --debug full
   ```

## Configuration

### Environment Variables
- `TZ`: Set timezone (default: America/New_York)

### Volume Mounts
- `./output:/app/output`: Local output directory for generated EPG files

### Network Configuration
The container uses `host` network mode to access local network devices like your HDHomeRun. If you need to use a different network configuration, you may need to adjust the networking settings.

### Parameters
All command-line parameters from the original script are supported:
- `--host`: HDHomeRun device hostname/IP (default: hdhomerun.local)
- `--filename`: Output file path (default: epg.xml)
- `--days`: Number of days to fetch (default: 7)
- `--hours`: Hours increment for fetching (default: 3)
- `--debug`: Debug level (on/off/full, default: on)

## Output
The generated EPG file will be saved in the `./output` directory on your host machine.

## Scheduled Execution
To run this automatically on a schedule, you can:

1. **Using cron (Linux/macOS):**
   ```bash
   # Add to crontab to run daily at 2 AM
   0 2 * * * cd /path/to/project && docker-compose up --build
   ```

2. **Using Windows Task Scheduler:**
   Create a scheduled task that runs the docker-compose command.

3. **Using a separate cron container:**
   Add a cron service to the docker-compose.yml file.
