rm_date=`grep rm_date /home/oracle/work/rm_date.log|awk '{print $2}'`
export rm_date
asmcmd << ! > /home/oracle/work/rm_standby_arch.dat
cd +ARCH/STDECHANDB/ARCHIVELOG/$rm_date
pwd
ls -l
!
