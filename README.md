
# docker-mongodb

A Docker container for running mongodb with support for backups, based on [Alpine Linux](https://alpinelinux.org/).

Full support for [backup-agent](https://github.com/tiberiuc/docker-backup-agent)

## Quick start

Requires that [Docker be installed](https://docs.docker.com/engine/installation/) on the host machine.

```
# Create some directory where your database data will be stored.
$ mkdir /home/youruser/mongo_data

$ docker run --name mongodb -d \
   --volume /home/youruser/mongo_data:/data/db \
   --publish 27017:27017 \
   --publish 9191:9191 \
   tiberiuc/mongodb

$ docker logs -f mongodb
[ ... ]
```

## Daemonizing

Currently mongodb is run inside supervisor

## Backup and restore

Backup
```
curl http://localhost:9191/backup -o mongodb.tgz
```

Restore
```
curl http://localhost:9191/restore --data-binary @./mongodb.tgz
```
