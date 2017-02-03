
#include "roscontroller.h"
#include <QDebug>
#include <cstring>
#include <cstdio>
#include <QHostInfo>
#include <QDataStream>
void ROSController::startListening()
{

}

void ROSController::runGraph(){
    system("/home/tyler/ground_system/graph/graph");
}

ROSController::ROSController(QObject * parent) : QObject(parent)
{

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
    tcpSocket->write(block);
    tcpSocket->close();
}


void ROSController::readyRead()
{
    //qDebug() << "In readyRead()...";
    // when data comes in
    QByteArray buffer;
    buffer.resize(udpSocket->pendingDatagramSize());

    QHostAddress sender;
    quint16 senderPort;

    udpSocket->readDatagram(buffer.data(), buffer.size(), &sender, &senderPort);


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

