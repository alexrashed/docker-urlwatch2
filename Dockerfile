FROM python:3
MAINTAINER Alexander Rashed

RUN pip3 install pyyaml minidb requests keyring chump pushbullet.py urlwatch

RUN apt-get update && apt-get install -y cron sshpass

# Put all logfiles into a volume. 
# Workaround for bug https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=810669
VOLUME /var/log/

RUN mkdir /config && mkdir /volume

WORKDIR /config

ENV LC_ALL="C.UTF-8"
ENV LANG="C.UTF-8"

ENV SCHEDULE="*/15 * * * *"

CMD echo "$SCHEDULE /bin/date >> /var/log/urlwatch.log 2>&1 && LANG=C.UTF-8 /usr/local/bin/urlwatch --urls /config/urls.txt --config /config/urlwatch.yaml --hooks /config/hooks.py --cache /volume/cache.db >> /var/log/urlwatch.log 2>&1" | crontab - && touch /var/log/urlwatch.log && cron && tail -f /var/log/urlwatch.log
