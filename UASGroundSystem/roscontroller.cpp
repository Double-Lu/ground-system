#include "roscontroller.h"
#include <QDebug>
#include <cstring>
#include <cstdio>
#include <QHostInfo>
#include <QDataStream>




void ROSController::startListening()
{

//    ListenerThread *listenerThread = new ListenerThread(this);
//    connect(listenerThread, &ListenerThread::resultReady, this, &ROSController::handleResults);
//    connect(listenerThread, &ListenerThread::finished, listenerThread, &QObject::deleteLater);
//    listenerThread->start();

}

ROSController::ROSController(QObject * parent) : QObject(parent)
{
    //qDebug() << "I'm in ROSController ctor!";

//    ros::NodeHandle node;

//    ros::Subscriber sub = node.subscribe("turtle1/pose", 10, &ROSController::handlePose, this);

    udpSocket = new QUdpSocket(this);
    udpSocket->bind(QHostAddress::LocalHost, 7755);

    connect(udpSocket, SIGNAL(readyRead()), this, SLOT(readyRead()));
    qDebug() << "udpSocket is live...";

    tcpSocket = new QTcpSocket(this);
    networkSession = Q_NULLPTR;


}

ROSController::~ROSController()
{
   udpSocket->close();
}


void ROSController::getMessage()
{
    emit messageReceived("This is a blank message");
}

void ROSController::sendCommand(QString cmd)
{
    QString LOCAL_HOST = QHostInfo::localHostName();
    tcpSocket->connectToHost(LOCAL_HOST, 8888);
    qDebug() << "in sendCommand() with message " << cmd <<" connected to " << LOCAL_HOST;
    QByteArray block;
    block.append(cmd);
//    QDataStream sendStream(&block, QIODevice::WriteOnly);
//    sendStream.setVersion(QDataStream::Qt_4_0);
//    QString msg = "msg:" + cmd;
//    sendStream << msg;
//    qDebug() << "about to send " << QString::fromLocal8Bit(block) << " over network.";
    tcpSocket->write(block);
    tcpSocket->close();
}
//void ROSController::handlePose(const turtlesim::PoseConstPtr&  rosMessage)
//{
//    emit messageReceived(QString::fromStdString( "This is a ROS message: {x=" + std::to_string(rosMessage->x) + ",y=" + std::to_string(rosMessage->y) + "}"));
//}


void ROSController::readyRead()
{
    //qDebug() << "In readyRead()...";
    // when data comes in
    QByteArray buffer;
    buffer.resize(udpSocket->pendingDatagramSize());

    QHostAddress sender;
    quint16 senderPort;

    udpSocket->readDatagram(buffer.data(), buffer.size(), &sender, &senderPort);

    //qDebug() << "I received " << buffer;

    emit messageReceived(buffer);
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
