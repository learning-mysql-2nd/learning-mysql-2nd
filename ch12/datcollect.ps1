$mysqlbin='C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe'
$mysqladminbin='C:\Program Files\MySQL\MySQL Server 8.0\bin\mysqladmin.exe'

$user="root"
$password="root"
$mysqlhost="127.0.0.1"

$destination='C:\tmp\collected_data'
$stopfile='C:\tmp\exit-flag'

if (-Not (Test-Path -Path "$destination")) {
  mkdir -p "$destination"
}

Start-Process -NoNewWindow $mysqlbin -ArgumentList `
  "-h$mysqlhost","-u$user","-p$password",'-e "SHOW GLOBAL VARIABLES;"' `
  -RedirectStandardOutput "$destination\variables"

while(1) {
  if (Test-Path -Path "$stopfile") {
    echo "Found exit monitor file, aborting"
    break;
  }
  $d=(Get-Date -Format "yyyy-MM-d_HHmmss")
  Start-Process -NoNewWindow $mysqlbin -ArgumentList `
    "-h$mysqlhost","-u$user","-p$password",'-e "SHOW ENGINE INNODB STATUS\G"' `
    -RedirectStandardOutput "$destination\$d-innodbstatus"
  Start-Process -NoNewWindow $mysqlbin -ArgumentList `
    "-h$mysqlhost","-u$user","-p$password",'-e "SHOW ENGINE INNODB MUTEX;"' `
    -RedirectStandardOutput "$destination\$d-innodbmutex"
  Start-Process -NoNewWindow $mysqlbin -ArgumentList `
    "-h$mysqlhost","-u$user","-p$password",'-e "SHOW FULL PROCESSLIST\G"' `
    -RedirectStandardOutput "$destination\$d-processlist"
  & $mysqladminbin "-h$mysqlhost" -u"$user" -p"$password" `
    -i1 -c15 ext > "$destination\$d-mysqladmin";
}
