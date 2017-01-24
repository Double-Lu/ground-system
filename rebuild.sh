#!/bin/bash


if [ -f UASGroundSystem/UASGroundSystem.pro ]
	then
		rm UASGroundSystem/UASGroundSystem.pro
fi
python configure_qt.py $HOME
source UASDrone/rebuild.sh