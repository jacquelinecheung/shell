#!/bin/ksh

read NUM
#NUM=21
TMPFILE=/tmp/top_cpu.txt
TIME=`date +%y%m%d%H%M%S`

USER=MONITORXN
PASS=MONITORXN
DB=GZCRMDB2

ps aux |grep oracle${DB} |head -${NUM} |awk '{print $2}' > $TMPFILE

getsql()
{
sqlplus -s ${USER}/${PASS}@${DB} << EOF
set line 300 pagesize 50000
select s.username, s.machine, s.program, s.sql_id, q.sql_text from v\$process p, v\$session s , v\$sql q where s.paddr = p.addr and s.sql_id = q.sql_id and p.spid = '$i
';
exit;

EOF
}

while read i
        do
                echo $i
                getsql $i 2>&1 |tee -a ./sql$TIME.log
        done < $TMPFILE

rm $TMPFILE
