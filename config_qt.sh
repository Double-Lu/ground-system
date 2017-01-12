#!/bin/bash
UAS_GROUND_PATH=$(pwd)
# Fill out UASGround.pro with correct info
cd $UAS_GROUND_PATH
if [ -f $UAS_GROUND_PATH/UASGround.pro ]
	then
		rm UASGround.pro
fi
python configure_qt.py $(cd ~ && pwd)