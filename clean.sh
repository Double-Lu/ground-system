#!/bin/bash

rm -rf UASDrone/build
rm -rf UASDrone/devel
rm -f UASDrone/src/CMakeLists.txt
cd UASGroundSystem
make clean
rm Makefile
rm UASGroundSystem
cd ..
