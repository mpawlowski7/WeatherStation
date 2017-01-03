#ifndef WSTHREAD_H
#define WSTHREAD_H

#include "wumanager.hpp"

#include <QThread>
#include <QTcpSocket>
#include <QDataStream>
#include <QHostAddress>

class WSThread : public QThread
{
    Q_OBJECT

signals:
    void error(QTcpSocket::SocketError socketError);

private:
    qintptr socketDescriptor;
    QTcpSocket* tcpSocket;

public:
    WSThread(qintptr socketDescriptor, QObject *parent);
    ~WSThread();
    void run() Q_DECL_OVERRIDE;

public slots:
    void disconnected();
    void readyRead();

};

#endif // WSTHREAD_H
