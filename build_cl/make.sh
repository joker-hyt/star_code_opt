
BOOST_OPTIONS='/I"E:\x51_trunc\src\boost_1_53_0"'

while read -r line
do
	#echo $line
	PROJ_FILE=`echo $line | awk '{ print $1 }'`
	
	echo -e `date "+%Y-%m-%d %H:%M:%S"`"\t"$PROJ_FILE
	
	cd $PROJ_FILE
	make > result.txt 2>&1
	cd ..
done < config.in
