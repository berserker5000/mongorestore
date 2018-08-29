#!/bin/sh

OPTIONS=`python /usr/local/bin/mongouri`
DB_NAME=`python /usr/local/bin/mongouri database`

IFS=","
for BACKUP_NAME in $BACKUP_NAMES
do
  # Decompress backup with progress
  cd /backup/ && pv $BACKUP_NAME | tar xzf - -C .

  # Run backup
  if [ -n "${COLLECTIONS}" ]; then
    for COLLECTION in $COLLECTIONS
    do
      cmd="mongorestore -v ${OPTIONS} -c ${COLLECTION} /backup/dump/${DB_NAME}/${COLLECTION}.bson"
      echo $cmd
      eval $cmd
    done
  else
    cmd="mongorestore -v ${OPTIONS} /backup/dump/"
    echo $cmd
    eval $cmd
  fi

  # Delete backup files
  sleep 60
  rm -rf /backup/dump/
done
