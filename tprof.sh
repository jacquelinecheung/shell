COUNTER=0

while [ $COUNTER -lt 100 ]
	do
		TIME=`date +%y%m%d%H%M%S`
		tprof -ukest -x sleep 10
		mv sleep.prof sleep.prof.$TIME
		COUNTER=`expr $COUNTER + 1`
		echo $COUNTER
	done
