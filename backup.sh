#!/bin/bash

#@@@VARIABLES
ARCHIEVE=/var/kahava/archieve/
ODBC=/var/kahava/odbc/*
BACKUP=root@192.168.56.109:/var/kahava/backup/
ARCHIEVE2=/var/kahava/archieve/*
TIME_STAMP=$(date +%Y.%m.%d-%H:%M:%S)
LOG_FILE=/var/kahava/log.txt



if cp $ODBC $ARCHIEVE 
then
 echo "All files copied to archieve folder at: $TIME_STAMP" >> $LOG_FILE 
else  echo "No file foud in odbc  at: $TIME_STAMP" >> $LOG_FILE

fi

echo "***************************************************" >> $LOG_FILE
echo "                                                 " >> $LOG_FILE

yes | rm $ODBC  && echo "All files removed on odbc folder at: $TIME_STAMP" >> $LOG_FILE


echo "***************************************************" >> $LOG_FILE
echo "                                                   " >> $LOG_FILE

if scp $ARCHIEVE2 $BACKUP 
then
   echo "All files copied to backup from archieve folder at: $TIME_STAMP" >> $LOG_FILE
else
   echo "Backup Failed, host unreachable at: $TIME_STAMP" >> $LOG_FILE
fi
echo "*****************************************************" >> $LOG_FILE
echo "                                                    " >> $LOG_FILE

yes | rm $ARCHIEVE2 && echo "All files removed from archieve folder after successfully copy to remote file at: $TIME_STAMP" >> $LOG_FILE 
echo "****************************************************" >> $LOG_FILE
echo "                                                    " >> $LOG_FILE
