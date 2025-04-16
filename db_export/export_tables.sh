#!/bin/bash

DB="dev_service_catalogue_backend"
USER="sa"
PASS="F@Thy_123456"
SERVER="localhost"

# جِب أسماء الجداول
/opt/mssql-tools/bin/sqlcmd -S $SERVER -U $USER -P $PASS -d $DB -h -1 -W -Q "SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE='BASE TABLE';" > tables.txt

while read table; do
    echo "Exporting $table ..."
    /opt/mssql-tools/bin/bcp $DB.dbo.$table out ~/db_export/${table}.dat -c -t, -S $SERVER -U $USER -P $PASS
done < tables.txt
