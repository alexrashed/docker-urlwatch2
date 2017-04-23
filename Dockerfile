FROM python:3
MAINTAINER Alexander Rashed
WORKDIR /config
RUN pip3 install pyyaml minidb requests keyring chump pushbullet.py urlwatch
CMD ["urlwatch", "--urls", "urls.txt", "--config", "urlwatch.yaml", "--hooks", "hooks.py"]
