# docker-urlwatch2
### Build:

`docker build .`

### Configure:

Create the configuration files for urlwatch2:

- urlwatch.yaml
- hooks.py
- urls.txt

### Run:

In the folder containing the configuratoin files execute `docker run -v ${PWD}:/config alexrashed/docker-urlwatch2` 

By default urlwatch is executed every 15 minutes (`*/15 * * * *`). If you want to change the schedule, add the environment variable `SCHEDULE` to a cron schedule value (f.e. `SCHEDULE="* * * * *"` for an execution every minute) when starting the container.

In order to persist the database across container recreations, mount the folder for the database to `/volume`.
