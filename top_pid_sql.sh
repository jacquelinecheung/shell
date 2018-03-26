#!/bin/ksh

NUM=21
TMPFILE=/tmp/top_cpu.txt
TIME=`date +%y%m%d%H%M%S`

PWD=`hostname`
echo $PWD

if [ "$PWD" = "S1_C_YZ_YZSJK" ]
then DB=gzdb1
fi

if [ "$PWD" = "S2_C_YZ_YZSJK" ]
then DB=gzdb2
fi

if [ "$PWD" = "S3_C_YZ_YZSJK" ]
then DB=szdb1
fi

if [ "$PWD" = "S4_C_YZ_YZSJK" ]
then DB=szdb2
fi

if [ "$PWD" = "S5_C_YZ_YZSJK" ]
then DB=dgdb1
fi

if [ "$PWD" = "S6_C_YZ_YZSJK" ]
then DB=dgdb2
fi

USER=jmyy
PASS=jmyy

ps aux |grep oracle${DB} |head -${NUM} |awk '{print $2}' > $TMPFILE

getsql()
{
sqlplus -s ${USER}/${PASS}@${DB} << EOF
select s.username, s.machine, s.program, s.sql_id, q.sql_text from v\$process p, v\$session s , v\$sql q where s.paddr = p.addr and s.sql_id = q.sql_id and p.spid = '$i';
exit;
	
EOF
}

while read i
	do
		echo $i
		getsql $i 2>&1 |tee -a ./sql$TIME.log
	done < $TMPFILE

rm $TMPFILE

