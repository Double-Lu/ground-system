#include "roscontroller.h"
#include <QDebug>




void ROSController::startListening()
{

//    ListenerThread *listenerThread = new ListenerThread(this);
//    connect(listenerThread, &ListenerThread::resultReady, this, &ROSController::handleResults);
//    connect(listenerThread, &ListenerThread::finished, listenerThread, &QObject::deleteLater);
//    listenerThread->start();

}

ROSController::ROSController(QObject * parent) : QObject(parent)
{

}

ROSController::~ROSController()
{

}

void ROSController::getMessage()
{
    emit messageReceived("This is a blank message");
}

void ROSController::initSocket()
{
    udpSocket = new QUdpSocket(this);
    udpSocket->bind(QHostAddress::LocalHost, 7755);

    connect(udpSocket, SIGNAL(readyRead()),
            this, SLOT(readPendingDatagrams()));
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
    }
}
