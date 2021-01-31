
BOOST_OPTIONS='/I"E:\x51_trunc\src\boost_1_53_0"'

while read -r line
do
	#echo $line
	PROJ_FILE=`echo $line | awk '{ print $1 }'`
	
	echo $PROJ_FILE
	
	cd $PROJ_FILE
	bash genonecpp.sh
	cd ..
done < config.in
