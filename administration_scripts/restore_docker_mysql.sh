#!/bin/bash

# Restore MySQL database running in a Docker container
# Author: Kate Lynch, with modifications by Jacob Levernier
# Source: https://gitlab.library.upenn.edu/katherly/colenda_backup_scripts/blob/master/backup_mysql.sh, https://gitlab.library.upenn.edu/katherly/colenda_backup_scripts/blob/master/README.md
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
LOCATION_OF_ENV_FILE="./config/mysql_authentication_variables.env"
source "$LOCATION_OF_ENV_FILE"

#################################
# Back up the MySQL database
#################################

currentDate=$(date "+%Y.%m.%d")

locationForBackup="$ENDPOINT/${currentDate}/$MYSQL_ENDPOINT"

mkdir -p "$locationForBackup"

echo "Restoring MYSQL backup to container '$MYSQL_CONTAINER' from '$locationForBackup'..."

cat "$locationForBackup"/backup.sql | docker exec -i $MYSQL_CONTAINER /usr/bin/mysql -u $MYSQL_USER --password=$MYSQL_PASSWORD $MYSQL_DATABASE 
