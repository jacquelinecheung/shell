#!/bin/sh

# Usage: ${progname} <DSN> <tblowner> <tblname>

DSN=$1
TBLOWNER=`echo $2 | tr "[:lower:]" "[:upper:]"`
TBLNAME=`echo $3 | tr "[:lower:]" "[:upper:]"`

FULLNAME=$TBLOWNER.$TBLNAME
echo $FULLNAME

ttisql -connStr "DSN=$DSN" -v 1 -e "call ttOptEstimateStats('$FULLNAME', 1, '51 PERCENT');\
select * from sys.tbl_stats where tblid = (select tblid from sys.tables where tblowner='$TBLOWNER' and tblname='$TBLNAME');exit"
