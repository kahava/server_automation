#!/bin/bash

#@@@VARIABLES
ARCHIEVE=/var/kahava/archieve/
ODBC=/var/kahava/odbc/*
BACKUP=root@192.168.56.109:/var/kahava/backup/
ARCHIEVE_FILE=/var/kahava/archieve/*
TIME_STAMP=$(date +%Y.%m.%d-%H:%M:%S)

LOG_FILE=/var/kahava/log.txt
RERUN_LIST=/var/kahava/rerun_list/
FAILED_BACKUP="Backup Failed, host unreachable at: $TIME_STAMP . Files moved to rerun list"
SUCCESS_BACKUP="Files Successfully copied from archieve to remote backup at: $TIME_STAMP . Removed all Files in archieve folder "
NO_ODBC="No file foud in odbc  at: $TIME_STAMP"
REMOVE_ODBC="Files copied to archieve folder. All files removed on odbc folder at: $TIME_STAMP"


MARGIN="_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _"
SPACE="                                                                                                        "
START="_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ ##@@@@@ BACKUP STARTED @@@@@##_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _"
END="_ _ _ _ _ _ __ _ _ _ _ _ _ _ _ _ _ _ _ _ _##@@@@@   BACKUP END   @@@@@##_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ "


echo $START >> $LOG_FILE
echo $SPACE >> $LOG_FILE

if cp $ODBC $ARCHIEVE 
then
    yes | rm $ODBC  && echo $REMOVE_ODBC >> $LOG_FILE
    echo $MARGIN >> $LOG_FILE
    echo $SPACE >> $LOG_FILE

    if scp $ARCHIEVE_FILE $BACKUP 
    then
    echo $SUCCESS_BACKUP >> $LOG_FILE
    yes | rm $ARCHIEVE_FILE 

    echo $MARGIN >> $LOG_FILE
    echo $SPACE >> $LOG_FILE

    else
    echo $FAILED_BACKUP >> $LOG_FILE
    mv $ARCHIEVE_FILE $RERUN_LIST
    fi
    echo $MARGIN >> $LOG_FILE
    echo $SPACE >> $LOG_FILE

else  echo $NO_ODBC >> $LOG_FILE
fi

echo $END >> $LOG_FILE
echo $SPACE >> $LOG_FILE                                                                                      


##CRON JOB
# */15 * * * * /path/to/script.sh