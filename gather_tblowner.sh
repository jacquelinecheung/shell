#!/bin/sh

# Usage: ${progname} <DSN> <tblowner>

DSN=$1
TBLOWNER=$2

ttisql -connStr "DSN=$DSN" -v 1 -e "select trim(tblowner)||'.'||trim(tblname) from sys.tables where tblowner=upper('$TBLOWNER');exit" |sed 's/< //g'|sed 's/ >//g' > /tmp/$TBLOWNER.txt

while read i
	do
		echo $i
		ttisql -connStr "DSN=$DSN" -v 1 -e "call ttOptEstimateStats('$i', 1, '51 PERCENT');exit"
	done < /tmp/$TBLOWNER.txt

ttisql -connStr "DSN=$DSN" -v 1 -e "select * from sys.tbl_stats where tblid in (select tblid from sys.tables where tblowner=upper('$TBLOWNER'));exit"

rm /tmp/$TBLOWNER.txt
