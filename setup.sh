#!/bin/bash

echo "creating folders and cloning repo..."

# mkdir UASGroundSystem
# cd UASGroundSystem
# git clone https://github.com/UAS-Ground/ground-system.git
# mv ground-system src

export PROJECT_ROOT=$(pwd)
export UAS_GROUND_PATH=$(pwd)/UASGroundSystem
export HOME_PATH=$(cd ~ && pwd)

# install ROS

cd ~
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116
sudo apt-get update
sudo apt-get install ros-kinetic-desktop-full
sudo rosdep init
rosdep update
echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc
source ~/.bashrc
sudo apt-get install python-rosinstall

# install OpenCV
sudo apt-get -y install libv4l-dev
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y dist-upgrade
sudo apt-get -y autoremove
sudo apt-get install -y build-essential cmake
sudo apt-get install -y qt5-default libvtk6-dev
sudo apt-get install -y zlib1g-dev libjpeg-dev libwebp-dev libpng-	dev libtiff5-dev libjasper-dev libopenexr-dev libgdal-dev
sudo apt-get install -y libdc1394-22-dev libavcodec-dev libavformat-dev libswscale-dev libtheora-dev libvorbis-dev libxvidcore-dev libx264-dev yasm libopencore-amrnb-dev libopencore-amrwb-dev libv4l-dev libxine2-dev
sudo apt-get install -y libtbb-dev libeigen3-dev
sudo apt-get install -y python-dev python-tk python-numpy python3-dev python3-tk python3-numpy
sudo apt-get install -y ant default-jdk
sudo apt-get install -y doxygen
sudo apt-get install -y unzip wget
cd ~
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
sudo make install
cd ~

# install QML-CVCamera plugin
wget https://github.com/chili-epfl/qml-cvcamera/archive/master.zip
unzip master.zip
rm master.zip
mv qml-cvcamera-master qml-cvcamera
cd qml-cvcamera
mkdir build-desktop
cd build-desktop
$HOME_PATH/Qt/5.7/gcc_64/bin/qmake ..
make -j 5
sudo make install

# Fill out UASGround.pro with correct info

cd $PROJECT_ROOT

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

