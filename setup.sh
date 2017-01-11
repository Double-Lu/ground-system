#!/bin/bash
UAS_GROUND_PATH = $(pwd)

# install OpenCV
sudo apt-get -y install libv4l-dev
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y dist-upgrade
sudo apt-get -y autoremove
sudo apt-get install -y build-essential cmake
sudo apt-get install -y qt5-default libvtk6-dev
sudo apt-get install -y zlib1g-dev libjpeg-dev libwebp-dev libpng-dev libtiff5-dev libjasper-dev libopenexr-dev libgdal-dev
sudo apt-get install -y libdc1394-22-dev libavcodec-dev libavformat-dev libswscale-dev libtheora-dev libvorbis-dev libxvidcore-dev libx264-dev yasm libopencore-amrnb-dev libopencore-amrwb-dev libv4l-dev libxine2-dev
sudo apt-get install -y libtbb-dev libeigen3-dev
sudo apt-get install -y python-dev python-tk python-numpy python3-dev python3-tk python3-numpy
sudo apt-get install -y ant default-jdk
sudo apt-get install -y doxygen
sudo apt-get install -y unzip wget
wget https://github.com/opencv/opencv/archive/3.2.0.zip
unzip 3.2.0.zip
rm 3.2.0.zip
mv opencv-3.2.0 OpenCV
cd OpenCV
mkdir build
cd build
cmake -DWITH_QT=ON -DWITH_OPENGL=ON -DFORCE_VTK=ON -DWITH_TBB=ON -DWITH_GDAL=ON -DWITH_XINE=ON -DBUILD_EXAMPLES=ON ..
make -j4
sudo make install
sudo ldconfig

# Special OpenCV build for QML-CVCamera plugin
cd ../platforms
mkdir build-desktop
cd build-desktop
cmake ../.. -DCMAKE_INSTALL_PREFIX=/usr -DWITH_GSTRAMER=OFF
make -j 5
make install
cd ~

# install QML-CVCamera plugin
wget https://github.com/chili-epfl/qml-cvcamera/archive/master.zip
unzip master.zip
rm master.zip
mv master qml-cvcamera
cd qml-cvcamera
mkdir build-desktop
cd build-desktop
/qt/install/root/5.3/gcc_64/bin/qmake ..
make -j 5
make install

# Fill out UASGround.pro with correct info
cd $UAS_GROUND_PATH
python configure_qt.py $(cd ~ && pwd)