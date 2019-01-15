#!/bin/bash

BACKUP_FOLDER=/tmp/backup
BACKUP_FILE=/tmp/mongodb.tgz

rm -f ${BACKUP_FILE}
rm -rf ${BACKUP_FOLDER}
mkdir -p ${BACKUP_FOLDER}

cd  ${BACKUP_FOLDER}

mongodump --quiet

tar -czf ${BACKUP_FILE} *

cd /

rm -rf ${BACKUP_FOLDER}

echo ${BACKUP_FILE}
