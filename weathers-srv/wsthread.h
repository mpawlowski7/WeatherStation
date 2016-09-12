#ifndef WSTHREAD_H
#define WSTHREAD_H

#include "wumanager.h"

#include <QThread>
#include <QTcpSocket>
#include <QDataStream>

class WSThread : public QThread
{

private:
    qintptr sd;

public:
    WSThread(qintptr sd, QObject *parent);
    void run() Q_DECL_OVERRIDE;

signals:
    void error(QTcpSocket::SocketError socketError);
};

#endif // WSTHREAD_H
