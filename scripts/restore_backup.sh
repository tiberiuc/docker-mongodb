#!/bin/bash

BACKUP_FOLDER=/tmp/backup
SAFE_FOLDER=/root/db_safe
BACKUP_FILE=$1

RESTORE_DATE=`date +%Y_%m_%d_%H_%M`
mkdir -p ${SAFE_FOLDER}

/usr/local/bin/backup.sh
mv /tmp/mongodb.tgz ${SAFE_FOLDER}/mongodb_${RESTORE_DATE}.tgz

rm -rf ${BACKUP_FOLDER}
mkdir -p ${BACKUP_FOLDER}

tar -xzf ${BACKUP_FILE} -C ${BACKUP_FOLDER}/

cd ${BACKUP_FOLDER}

mongorestore --quiet

rm -rf ${BACKUP_FOLDER}

echo Backup restored
