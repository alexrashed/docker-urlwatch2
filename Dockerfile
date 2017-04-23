FROM python:3
MAINTAINER Alexander Rashed

WORKDIR /config

RUN pip3 install pyyaml minidb requests keyring chump pushbullet.py urlwatch

ENV SCHEDULE="*/15 * * * *"

RUN apt-get update && apt-get install -y cron

CMD touch /var/log/urlwatch.log && { cat; echo "$SCHEDULE PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin && cd /config && date >> /var/log/urlwatch.log 2>&1 && urlwatch --urls urls.txt --config urlwatch.yaml --hooks hooks.py >> /var/log/urlwatch.log 2>&1";} | crontab - && cron && tail -f /var/log/urlwatch.log
