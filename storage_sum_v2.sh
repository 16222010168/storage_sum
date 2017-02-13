#!/usr/bin/ksh
ACTIVEVG=$(lsvg -o|grep -v rootvg)
if [ -z "$ACTIVEVG" ]
then
	echo "No External Storage"
else
	for i in $ACTIVEVG
	do
			lsvg $i|grep 'USED PPs'|awk '{print $6}'|sed 's/^(//'>> /tmp/storage`date +%d%m%y`.log
			lsvg $i|grep 'USED PPs'|awk '{print $5}'>> /tmp/USED`date +%d%m%y`.log
			lsvg $i|grep 'TOTAL PPs:'|awk '{print $6}'>> /tmp/TOTAL`date +%d%m%y`.log			
	done
	
	SUMUSED=$(awk '{sum += $1};END {print sum}' /tmp/storage`date +%d%m%y`.log)
	SUMUSEDSPC=$(awk '{sum += $1};END {print sum}' /tmp/USED`date +%d%m%y`.log)
	TOTALSPC=$(awk '{sum += $1};END {print sum}' /tmp/TOTAL`date +%d%m%y`.log)
	USEDSPC=$(expr $SUMUSED / 1024)
	PCT=$(expr $SUMUSEDSPC / $TOTALSPC)
	echo $USEDSPC
	echo $PCT
	
	rm /tmp/storage`date +%d%m%y`.log
	rm /tmp/USED`date +%d%m%y`.log
	rm /tmp/TOTAL`date +%d%m%y`.log
	
fi

