export ORACLE_SID=echandb1

rm_date=`grep rm_date /home/oracle/work/rm_date.log|awk '{print $2}'`
export rm_date

grep -v ASMCMD /home/oracle/work/rm_standby_arch.dat|while read line
do
if [ "$line" ];then
file_name=`echo $line|awk '{print $8 }'`
#echo $file_name
echo "+ARCH/stdechandb/archivelog/$rm_date/$file_name"|read f_file_name
sqlplus -s '/ as sysdba' <<  ! >/home/oracle/work/rm_standby_arch.flag
set heading off
select 'Archived: ' from v\$archived_log where upper(name)=upper('$f_file_name') and APPLIED='YES';
!

grep Archived /home/oracle/work/rm_standby_arch.flag |wc -l |read flag
if [ $flag -eq 1 ];then
echo "rm $f_file_name"
echo "rm $f_file_name" >> /home/oracle/work/rm_standby_arch.sh
fi

fi
done

echo "!" >> /home/oracle/work/rm_standby_arch.sh
