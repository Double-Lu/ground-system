#!/bin/bash

rm -rf build/ devel/ src/CMakeLists.txt
catkin_make
source devel/setup.bash

