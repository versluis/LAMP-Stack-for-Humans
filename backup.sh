#!/bin/bash
#
# LAMP Stack Backup Script
# Version 0.4
# 29/11/2016 
# by Jay Versluis
#

# VARIABLES
LOGFILE="/var/log/dailybackup.log"
MASTERLOG="/var/log/backup.log"
EMAIL="you@domain.com"
START_TIME=$(date +"%x %r")
MYSQL_USER="root"
MYSQL_PASS="password"
MYSQL_DB="your-database"

function dumpDatabase {

    # delete current database backup
	echo >> $LOGFILE
	echo "Removing current database file..." >> $LOGFILE
	rm /var/www/html/databases/teamdiary.sql >> $LOGFILE
	
	# dump current database
	echo >> $LOGFILE
	echo "Dumping fresh database..." >> $LOGFILE
	mysqldump $MYSQL_DB -u $MYSQL_USER -p$MYSQL_PASS > /var/www/html/databases/teamdiary.sql # >> $LOGFILE
}

function copyContent {

	# copy whole directory to SD card (including .htaccess)
	echo >> $LOGFILE
	echo "Copying directory to SD Card..." >> $LOGFILE
	rsync -rvPz --no-whole-file --delete /var/www/html/* /backup >> $LOGFILE
	rsync /var/www/html/.htaccess /backup >> $LOGFILE

}

function startLogFile {

   #delete current log file
   rm -f $LOGFILE
   
   # start header of new log file
   echo "Backing up TEAM DIARY on NC10" >> $LOGFILE
   echo "=============================" >> $LOGFILE
   echo >> $LOGFILE
   echo "started $START_TIME" >> $LOGFILE
   echo >> $LOGFILE
}

function finishLogFile {
   
   # add finished timestamp to log file
   END_TIME=$(date +"%x %r")
   echo "=============================" >> $LOGFILE
   echo "Backup finished $END_TIME." >> $LOGFILE
   echo "See you tomorrow ;-)" >> $LOGFILE
   echo >> $LOGFILE
   echo >> $LOGFILE
   echo "Lots of love from THE BACKUP SCRIPT at NC10!" >> $LOGFILE
}

function sendEmail {

   #send email with log file 
   cat $LOGFILE | mail -s "Daily Backup Log" $EMAIL

}

function dailyLog {

   # append start and end time to daily log file
   echo "=============================" >> $MASTERLOG
   echo "Backup started at" $START_TIME >> $MASTERLOG
   echo "Finished at" $END_TIME >> $MASTERLOG
   echo >> $MASTERLOG

}

# write log file
# determine start time
# start the process
# determine end time
# send email 

startLogFile
dumpDatabase
copyContent
finishLogFile
sendEmail

# update daily log file
dailyLog

#
echo
echo 
echo "Done!"
