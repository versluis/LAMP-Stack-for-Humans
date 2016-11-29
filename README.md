# LAMP Stack Backup Script

A simple backup script for a single LAMP Stack, as discussed in my book "LAMP Stack for Humans", available from Amazon.com: https://www.amazon.com/dp/B00V6WAHWC

### Purpose
As I have discussed in my book, if you're running a web application in the comfort of your own home on an hold laptop, it might be a good idea to backup the whole LAMP stack occastionaly. This script is desigend to do just that. 

I have written the script with CentOS in mind. Other distributions store web files in a directory other than /var/www/html. The rest of the script should work fine if you change referneces to this path.

It assumes that a directory called /backup exists and is ready to accept a complete copy of the whole /var/www/html directory, including a dump of the database. On my box, /backup is an SD card. I have described how the backup and restore process works in my book.

### Usage
* Edit the variables at the top of the script to match your stack and preferences
* make your file executable (chmod +x)
* run it as often as you like, perhaps even add it to crontab for automatic backups

### Log FiLes
The script can generate two separate log files: 

The LOGFILE is a detailed output of the copying process. This can be rather large, but will flag up problems as they occur. Due to its size, the file is overwritten every time you run this script.

The MASTERLOG is a much shorter version and simply logs when the script was started and when it finished. It is appended to every time the script runs.

### Known Issues
For daily email notifications to work, make sure your MTA client is configured. If it is, and you're still not getting emails from your own server, your ISP may block port 25 which is used for outgoing emails (because you could potentially run a spam bot from home, and they don't want you to do that). In which case, comment out the call to send emails at the bottom of the script.

### License
This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html
