#!/bin/bash
DATADEST="/tmp/collected_data";
MYSQL="mysql --host=127.0.0.1  -uroot -proot";
MYSQLADMIN="mysqladmin  --host=127.0.0.1 -uroot -proot";
[ -d "$DATADEST" ] || mkdir $DATADEST;
while true; do {
  [ -f /tmp/exit-flag ] \
    && echo "exiting loop (/tmp/exit-flag found)" \
    && break;
  d=$(date +%F_%T |tr ":" "-");
  $MYSQL -e "SHOW ENGINE INNODB STATUS\G" > $DATADEST/$d-innodbstatus &
  $MYSQL -e "SHOW ENGINE INNODB MUTEX;" > $DATADEST/$d-innodbmutex &
  $MYSQL -e "SHOW FULL PROCESSLIST\G" > $DATADEST/$d-processlist &
  $MYSQLADMIN -i1 -c15 ext > $DATADEST/$d-mysqladmin ;
} done;
$MYSQL -e "SHOW GLOBAL VARIABLES;" > $DATADEST/$d-variables;
