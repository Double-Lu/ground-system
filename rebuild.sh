#!/bin/bash



if [ -d UASDrone/build ]
	then
		rm -rf UASDrone/build
fi


if [ -d UASDrone/devel ]
	then
		rm -rf UASDrone/build
fi


if [ -f UASDrone/src/CMakeLists.txt ]
	then
		rm UASDrone/src/CMakeLists.txt
fi

if [ -f UASGroundSystem/UASGroundSystem ]
	then
		rm UASGroundSystem/UASGroundSystem 
fi


if [ -f UASGroundSystem/UASGroundSystem.pro ]
	then
		rm UASGroundSystem/UASGroundSystem.pro
fi

python configure_qt.py $HOME
cd UASDrone/
source rebuild.sh
cd ../UASGroundSystem
make clean


if [ -f UASGroundSystem/Makefile ]
	then
		rm UASGroundSystem/Makefile 
fi

$HOME/Qt/5.7/gcc_64/bin/qmake
make
cd ..


