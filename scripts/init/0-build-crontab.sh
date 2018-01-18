#!/bin/sh

rm /app/files/generated-crontab > /dev/null 2>&1
cat /app/files/default-crontab > /app/files/generated-crontab

# TODO: Pull cron timings from env vars better
if [ "$MIRROR_MINUTES" ]; then
    echo "*/$MIRROR_MINUTES * * * * bash /app/scripts/mc-mirror-src2dest.sh" >> /app/files/generated-crontab
else
    echo "*/15 * * * * bash /app/scripts/mc-mirror-src2dest.sh" >> /app/files/generated-crontab
fi

echo "" >> /app/files/generated-crontab

# cat /app/files/generated-crontab
