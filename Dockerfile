FROM tiberiuc/backup-agent as backup
MAINTAINER Tiberiu Craciun <tibi@happysoft.ro>


FROM alpine:edge
RUN apk update \
  && apk --no-cache add tar bash supervisor bzip2 inotify-tools mongodb mongodb-tools \
  && rm -rf /var/cache/apk/* /tmp/*

COPY --from=backup /usr/local/bin/backup_agent /usr/local/bin/backup_agent

VOLUME /data/db
EXPOSE 27017 28017 9191

ADD ./scripts/backup.sh /usr/local/bin/backup.sh
ADD ./scripts/restore_backup.sh /usr/local/bin/restore_backup.sh
ADD ./scripts/mongodb_entrypoint.sh /usr/local/bin/mongodb_entrypoint.sh
ADD ./scripts/start_mongodb.sh /usr/local/bin/start_mongodb.sh
RUN chmod a+x /usr/local/bin/mongodb_entrypoint.sh \
    && chmod a+x /usr/local/bin/start_mongodb.sh \
    && chmod a+x /usr/local/bin/backup.sh \
    && chmod a+x /usr/local/bin/restore_backup.sh

ENTRYPOINT ["/usr/local/bin/mongodb_entrypoint.sh"]
CMD [ "mongod", "--bind_ip", "0.0.0.0" , "--dbpath", "/data/db" ]
