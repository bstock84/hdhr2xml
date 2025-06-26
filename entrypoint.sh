#! /bin/sh

# get sleep time from environment variable or default to 12 hours
if [ -z "$SLEEP_TIME" ]; then
  SLEEP_TIME=43200  # 12 hours in seconds
fi

while true; do
  DATE=$(date '+%Y-%m-%d %H:%M:%S')
  echo "Running EPG to XML at $DATE"
  python ./HDHomeRunEPG_To_XmlTv.py "$@"
  # sleep for 12 hours
  echo "Sleeping..."
  sleep "$SLEEP_TIME"
done