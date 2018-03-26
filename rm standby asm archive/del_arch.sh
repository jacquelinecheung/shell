#!/bin/ksh

if [ $# != 1 ];then
echo "Please input ORACLE_SID ..."
exit
fi

> /home/oracle/work/rm_standby_arch.sh
echo "asmcmd << !" > /home/oracle/work/rm_standby_arch.sh
su - oracle -c "/home/oracle/work/inp_oracle.sh"
rm_date=`grep rm_date /home/oracle/work/rm_date.log|awk '{print $2}'`
echo $rm_date
su - grid -c "/home/oracle/work/inp_grid.sh"

su - oracle -c "/home/oracle/work/inp_oracle2.sh"

su - grid -c "/home/oracle/work/rm_standby_arch.sh"

