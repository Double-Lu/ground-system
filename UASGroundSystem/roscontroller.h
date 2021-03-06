#ifndef ROSCONTROLLER_H
#define ROSCONTROLLER_H

#include <QObject>
#include <QUdpSocket>
#include <QTcpSocket>
#include <QNetworkSession>
//#include <ros/ros.h>
//#include <ros/roscpp_serialization_macros.h>
//#include <turtlesim/Pose.h>


class ROSController : public QObject
{
    Q_OBJECT
public:
    explicit ROSController( QObject * parent = 0 );
    ~ROSController();
    Q_INVOKABLE void getMessage();
    Q_INVOKABLE void sendCommand(QString cmd);
    //void handlePose(const turtlesim::PoseConstPtr& rosMessage);
    void initSocket();
    void readPendingDatagrams();
    void startListening();
    void myFunc();
    Q_INVOKABLE void runGraph();


private:
    QUdpSocket * udpSocket;
    QTcpSocket * tcpSocket;

    QNetworkSession * networkSession;
signals:
    void messageReceived(QString message);
public slots:
    void readyRead();
};


#endif // ROSCONTROLLER_H
