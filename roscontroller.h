#ifndef ROSCONTROLLER_H
#define ROSCONTROLLER_H

#include <QObject>
#include <QUdpSocket>


class ROSController : public QObject
{
    Q_OBJECT
public:
    explicit ROSController( QObject * parent = 0 );
    ~ROSController();
    Q_INVOKABLE void getMessage();
    void initSocket();
    void readPendingDatagrams();
    void startListening();
private:
    QUdpSocket * udpSocket;
signals:
    void messageReceived(QString message);
public slots:
};


#endif // ROSCONTROLLER_H
