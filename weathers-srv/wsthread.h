#ifndef WSTHREAD_H
#define WSTHREAD_H

#include "wumanager.h"

#include <QThread>
#include <QTcpSocket>
#include <QDataStream>

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
    void run() Q_DECL_OVERRIDE;

public slots:
    void disconnected();

};

#endif // WSTHREAD_H
