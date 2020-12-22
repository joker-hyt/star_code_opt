
ROOT_PATH='..\..\'
BOOST_OPTIONS='/I"E:\x51_trunc\src\boost_1_53_0"'

while read -r line
do
	#echo $line
	PROJ_FILE=`echo $line | awk '{ print $1 }'`
	PROJ_PATH=`echo $line | awk '{ print $2 }'`
	PROJ_PATH=`echo $ROOT_PATH$PROJ_PATH`
	PROJ_PATH_WIN=`echo $PROJ_PATH | sed 's/\\\\/\\\\\\\\/g'`
	PROJ_PATH_LINUX=`echo $PROJ_PATH | sed 's/\\\\/\\\\\\//g'`
	PROJ_PCH_CPP=`echo $line | awk '{ print $3 }'`
	
	PROJ_OPTIONS=`echo $line | awk '{ for(i = 4; i <= NF; ++i) printf("%s ", $i) }' | sed 's/\\/I"/\\/I"'$PROJ_PATH_WIN'\\\\/g'`
	PROJ_OPTIONS=`echo $PROJ_OPTIONS | sed 's/\\/Fa"[^"]*"/\\/Fa"Debug\\\\"/g'`
	PROJ_OPTIONS=`echo $PROJ_OPTIONS | sed 's/\\/Fo"[^"]*"/\\/Fo"Debug\\\\"/g'`
	PROJ_OPTIONS=`echo $PROJ_OPTIONS | sed 's/\\/Fd"[^"]*pdb"/\\/Fd"Debug\\\\pdb.pdb"/g'`
	PROJ_OPTIONS=`echo $PROJ_OPTIONS | sed 's/\\/Fp"[^"]*pch"/\\/Fp"Debug\\\\pch.pch"/g'`
	PROJ_OPTIONS_CPP_P=`echo $PROJ_OPTIONS`
	PROJ_OPTIONS_PCH_P=`echo $PROJ_OPTIONS | sed 's/\\/Yu"/\\/Yc"/g'`
	PROJ_OPTIONS_CXX_P=`echo $PROJ_OPTIONS | sed 's/\\/Yu"[^ ]* //g' | sed 's/\\/FI"[^ ]* //g'`
	PROJ_OPTIONS_CPP=`echo $PROJ_OPTIONS_CPP_P' '$BOOST_OPTIONS | sed 's/\\\\/\\\\\\\\/g' | sed 's/\\\\\\\\"/\\\\\\\\\\\\\\\\"/g' | sed 's/\\\\/\\\\\\\\/g' | sed 's/\\//\\\\\\//g'`
	PROJ_OPTIONS_PCH=`echo $PROJ_OPTIONS_PCH_P' '$BOOST_OPTIONS | sed 's/\\\\/\\\\\\\\/g' | sed 's/\\\\\\\\"/\\\\\\\\\\\\\\\\"/g' | sed 's/\\\\/\\\\\\\\/g' | sed 's/\\//\\\\\\//g'`
	PROJ_OPTIONS_CXX=`echo $PROJ_OPTIONS_CXX_P' '$BOOST_OPTIONS | sed 's/\\\\/\\\\\\\\/g' | sed 's/\\\\\\\\"/\\\\\\\\\\\\\\\\"/g' | sed 's/\\\\/\\\\\\\\/g' | sed 's/\\//\\\\\\//g'`

	echo $PROJ_FILE
	
	rm -rf $PROJ_FILE && mkdir $PROJ_FILE && cd $PROJ_FILE && cp ../genm.sh.template ./genm.sh
	sed -i "s/{{PROJ_FILE}}/$PROJ_FILE/g" ./genm.sh
	sed -i "s/{{PROJ_PATH}}/$PROJ_PATH_LINUX/g" ./genm.sh
	sed -i "s/{{PROJ_PCH_CPP}}/$PROJ_PCH_CPP/g" ./genm.sh
	sed -i "s/{{PROJ_OPTIONS_CPP}}/$PROJ_OPTIONS_CPP/g" ./genm.sh
	sed -i "s/{{PROJ_OPTIONS_PCH}}/$PROJ_OPTIONS_PCH/g" ./genm.sh
	sed -i "s/{{PROJ_OPTIONS_CXX}}/$PROJ_OPTIONS_CXX/g" ./genm.sh
	cd ..
done < config.in
