base = """
QT += qml quick opengl multimedia

CONFIG += c++11

SOURCES += main.cpp \
    roscontroller.cpp
#    cqtopencvviewergl.cpp \
#    listener.cpp

RESOURCES += qml.qrc


#include(/home/tyler/Downloads/livecv/api/pro/lcv.pro)

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# The following define makes your compiler emit warnings if you use
# any feature of Qt which as been marked deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

# Default rules for deployment.
qnx: target.path = /tmp/$${{TARGET}}/bin
else: unix:!android: target.path = /opt/$${{TARGET}}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    roscontroller.h


OPENCV_PATH = {0}/OpenCV

LIBS_PATH = {0}/OpenCV/build/lib

LIBS     += \
    -L$$LIBS_PATH \
    -lopencv_core \
    -lopencv_highgui \
    -lopencv_imgproc \
    -lopencv_videoio


INCLUDEPATH += \
    $$OPENCV_PATH/modules/core/include/ \ #core module
    $$OPENCV_PATH/modules/highgui/include/ \ #highgui modul
    /opt/ros/kinetic/include/



message("OpenCV path: $$OPENCV_PATH")
message("Includes path: $$INCLUDEPATH")
message("Libraries: $$LIBS")

DISTFILES += \
    indicator.png

"""


roscontroller_implementation = """
#include "roscontroller.h"
#include <QDebug>
#include <cstring>
#include <cstdio>
#include <QHostInfo>
#include <QDataStream>
void ROSController::startListening()
{{

}}

void ROSController::runGraph(){{
    system("{0}/ground_system/graph/graph");
}}

ROSController::ROSController(QObject * parent) : QObject(parent)
{{

    udpSocket = new QUdpSocket(this);
    udpSocket->bind(QHostAddress::LocalHost, 7755);

    connect(udpSocket, SIGNAL(readyRead()), this, SLOT(readyRead()));
    qDebug() << "udpSocket is live...";

    tcpSocket = new QTcpSocket(this);
    networkSession = Q_NULLPTR;


}}

ROSController::~ROSController()
{{
   udpSocket->close();
}}


void ROSController::getMessage()
{{
    emit messageReceived("This is a blank message");
}}

void ROSController::sendCommand(QString cmd)
{{
    QString LOCAL_HOST = QHostInfo::localHostName();
    tcpSocket->connectToHost(LOCAL_HOST, 8888);
    qDebug() << "in sendCommand() with message " << cmd <<" connected to " << LOCAL_HOST;
    QByteArray block;
    block.append(cmd);
    tcpSocket->write(block);
    tcpSocket->close();
}}


void ROSController::readyRead()
{{
    //qDebug() << "In readyRead()...";
    // when data comes in
    QByteArray buffer;
    buffer.resize(udpSocket->pendingDatagramSize());

    QHostAddress sender;
    quint16 senderPort;

    udpSocket->readDatagram(buffer.data(), buffer.size(), &sender, &senderPort);


    emit messageReceived(buffer);
}}

void ROSController::readPendingDatagrams()
{{
    while (udpSocket->hasPendingDatagrams()) {{
        QByteArray datagram;
        datagram.resize(udpSocket->pendingDatagramSize());
        QHostAddress sender;
        quint16 senderPort;

        udpSocket->readDatagram(datagram.data(), datagram.size(),
                               &sender, &senderPort);

        printf("%s\\n",datagram.data());
        emit messageReceived("This is a blank message");
    }}
}}

"""

import sys

home_path = sys.argv[1]

uas_qt_file = open('UASGroundSystem/UASGroundSystem.pro', 'w')
formatted_uas_qt_contents = base.format(home_path)
uas_qt_file.write(formatted_uas_qt_contents)
uas_qt_file.close()


roscontroller_file = open('UASGroundSystem/roscontroller.cpp', 'w')
formatted_ros_controller_contents = roscontroller_implementation.format(home_path)
roscontroller_file.write(formatted_ros_controller_contents)
roscontroller_file.close()
