#!/usr/bin/ksh
ACTIVEVG=$(lsvg -o|grep -v rootvg)
if [ -z "$ACTIVEVG" ]
then
	echo "No External Storage"
else
	for i in $ACTIVEVG
	do
			lsvg $i|grep 'USED PPs'|awk '{print $6}'|sed 's/^(//'>> /tmp/storage`date +%d%m%y`.log
	done
	
	
	SUM=$(awk '{sum += $1};END {print sum}' /tmp/storage`date +%d%m%y`.log)
	USEDSPC=$(expr $SUM / 1024)
	echo $USEDSPC
	rm /tmp/storage`date +%d%m%y`.log
	
fi
