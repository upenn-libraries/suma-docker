#!/bin/bash

# Backup MySQL database running in a Docker container
# Author: Kate Lynch, with modifications by Jacob Levernier
# Source: https://gitlab.library.upenn.edu/katherly/colenda_backup_scripts/blob/master/backup_mysql.sh
# License: MIT

#################################
# Settings
#################################

# Backup directories. These should NOT have a trailing slash ('/'):
ENDPOINT=docker_backups  # The general backup directory
MYSQL_ENDPOINT=mysql_database  # The mysql-specific subdirectory of $ENDPOINT

MYSQL_CONTAINER=suma_mysql  # Name of the MySQL Docker container. This is set using container_name in the docker_compose.yml file.

# Load the MySQL docker env_file. This contains the following variables:
# MYSQL_DATABASE
# MYSQL_USER
# MYSQL_PASSWORD
LOCATION_OF_ENV_FILE="./config/mysql.env"
source "$LOCATION_OF_ENV_FILE"

#################################
# Back up the MySQL database
#################################

currentDate=$(date "+%Y.%m.%d.%H.%M")

locationForBackup="$ENDPOINT/${currentDate}/$MYSQL_ENDPOINT"

mkdir -p "$locationForBackup"

echo "Saving MYSQL backup to '$locationForBackup'..."

docker exec $MYSQL_CONTAINER mysqldump -u $MYSQL_USER --password=$MYSQL_PASSWORD $MYSQL_DATABASE > "$locationForBackup"/backup.sql 2>"$locationForBackup"/errors

chmod 400 "$locationForBackup"/backup.sql
