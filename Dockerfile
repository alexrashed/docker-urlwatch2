FROM python:3
MAINTAINER Alexander Rashed

RUN pip3 install pyyaml minidb requests keyring chump pushbullet.py urlwatch

RUN apt-get update && apt-get install -y cron

RUN mkdir /config && mkdir /volume && touch /var/log/urlwatch.log

WORKDIR /config

ENV LC_ALL="C.UTF-8"
ENV LANG="C.UTF-8"

ENV SCHEDULE="*/15 * * * *"

CMD { cat; echo "$SCHEDULE PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin && cd /config && date >> /var/log/urlwatch.log 2>&1 && urlwatch --urls urls.txt --config urlwatch.yaml --hooks hooks.py --cache /volume/cache.db >> /var/log/urlwatch.log 2>&1";} | crontab - && cron && tail -f /var/log/urlwatch.log
