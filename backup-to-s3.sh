#!/bin/bash

################################################################
##   Backup to S3
##
##   crontab weekly backup
##   @weekly ~/backup-to-s3.sh > /dev/null 2>&1
################################################################

NOW=$(date +"%Y-%m-%d")
NOW_TIME=$(date +"%Y-%m-%d %T %p")
NOW_MONTH=$(date +"%Y-%m")

BACKUP_DIR="/home/cwilliams/backup/$NOW_MONTH"
BACKUP_FILENAME="docker-$NOW.tar.gz"
BACKUP_FULL_PATH="$BACKUP_DIR/$BACKUP_FILENAME"

AMAZON_S3_BUCKET="s3://BUCKET_NAME/PATH/$NOW_MONTH/"
AMAZON_S3_BIN="/usr/local/bin/aws"

#can put multiple files or directories seperated by space
CONF_FOLDERS_TO_BACKUP=("/srv/config") #can put multiple files or directories seperated by space
SITE_FOLDERS_TO_BACKUP=("/data/compose" "/data/appsettings.json" "/data/kavita.db" "/data/nextcloud")

#################################################################

mkdir -p ${BACKUP_DIR}

backup_files(){
        tar -czf ${BACKUP_DIR}/${BACKUP_FILENAME} ${CONF_FOLDERS_TO_BACKUP[@]} ${SITE_FOLDERS_TO_BACKUP[@]}
}

upload_s3(){
        ${AMAZON_S3_BIN} s3 cp ${BACKUP_FULL_PATH} ${AMAZON_S3_BUCKET}
}

backup_files
upload_s3

# this is optional, we use mailgun to send email for the status update
#if [ $? -eq 0 ]; then
#        # if success, send out an email
#        curl -s --user "api:key..." \
#                https://api.mailgun.net/v3/mg.mkyong.com/messages \
#                -F from="backup job <backup@mkyong.com>" \
#                -F to=user@yourdomain.com \
#                -F subject="Backup Successful (Site) - $NOW" \
#                -F text="File $BACKUP_FULL_PATH is backup to $AMAZON_S3_BUCKET, time:$NOW_TIME"
#else
#        # if failed, send out an email
#        curl -s --user "api:key..." \
#                https://api.mailgun.net/v3/mg.mkyong.com/messages \
#                -F from="backup job <backup@yourdomain.com>" \
#                -F to=user@yourdomain.com \
#                -F subject="Backup Failed! (Site) - $NOW" \
#                -F text="Unable to backup!? Please check the server log!"
#fi;

#if [ $? -eq 0 ]; then
#  echo "Backup is done! ${NOW_TIME}" | mail -s "Backup Successful (Site) - ${NOW}" -r cron admin@mkyong.com
#else
#  echo "Backup is failed! ${NOW_TIME}" | mail -s "Backup Failed (Site) ${NOW}" -r cron admin@mkyong.com
#fi;