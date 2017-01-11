#include "roscontroller.h"
#include <QDebug>
#include <cstring>
#include <cstdio>




void ROSController::startListening()
{

//    ListenerThread *listenerThread = new ListenerThread(this);
//    connect(listenerThread, &ListenerThread::resultReady, this, &ROSController::handleResults);
//    connect(listenerThread, &ListenerThread::finished, listenerThread, &QObject::deleteLater);
//    listenerThread->start();

}

ROSController::ROSController(QObject * parent) : QObject(parent)
{

//    ros::NodeHandle node;

//    ros::Subscriber sub = node.subscribe("turtle1/pose", 10, &ROSController::handlePose, this);

    udpSocket = new QUdpSocket(this);
    udpSocket->bind(QHostAddress::LocalHost, 7755);

    connect(udpSocket, SIGNAL(readyRead()), this, SLOT(readyRead()));

}

ROSController::~ROSController()
{

}

void ROSController::getMessage()
{
    emit messageReceived("This is a blank message");
}
//void ROSController::handlePose(const turtlesim::PoseConstPtr&  rosMessage)
//{
//    emit messageReceived(QString::fromStdString( "This is a ROS message: {x=" + std::to_string(rosMessage->x) + ",y=" + std::to_string(rosMessage->y) + "}"));
//}

void ROSController::initSocket()
{
    udpSocket = new QUdpSocket(this);
    udpSocket->bind(QHostAddress::LocalHost, 7755);

    connect(udpSocket, SIGNAL(readyRead()),
            this, SLOT(readPendingDatagrams()));
}

void ROSController::readyRead()
{
    emit messageReceived("About to read data");
    // when data comes in
    QByteArray buffer;
    buffer.resize(udpSocket->pendingDatagramSize());

    QHostAddress sender;
    quint16 senderPort;

    udpSocket->readDatagram(buffer.data(), buffer.size(), &sender, &senderPort);

    emit messageReceived("Current position: " + buffer);
}

void ROSController::readPendingDatagrams()
{
    while (udpSocket->hasPendingDatagrams()) {
        QByteArray datagram;
        datagram.resize(udpSocket->pendingDatagramSize());
        QHostAddress sender;
        quint16 senderPort;

        udpSocket->readDatagram(datagram.data(), datagram.size(),
                               &sender, &senderPort);

        printf("%s\n",datagram.data());
        emit messageReceived("This is a blank message");
    }
}
