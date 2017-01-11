#ifndef ROSCONTROLLER_H
#define ROSCONTROLLER_H

#include <QObject>
#include <QUdpSocket>
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
    //void handlePose(const turtlesim::PoseConstPtr& rosMessage);
    void initSocket();
    void readPendingDatagrams();
    void startListening();
private:
    QUdpSocket * udpSocket;
signals:
    void messageReceived(QString message);
public slots:
    void readyRead();
};


#endif // ROSCONTROLLER_H
