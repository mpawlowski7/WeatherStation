#ifndef NETWORKMANAGER_H
#define NETWORKMANAGER_H

#include "WSThread.h"

#include <QTcpServer>
#include <QMutex>

class WSServer : public QTcpServer
{
    Q_OBJECT
    Q_DISABLE_COPY(WSServer)

private:
    static WSServer* volatile p_instance;
    WSServer(QObject* parent = 0) : QTcpServer(parent)
    {
    }
    ~WSServer();
    const int port = 8786;

public:
    static WSServer* instance();
    void startServer();

protected:
    void incomingConnection(qintptr sd) Q_DECL_OVERRIDE;

};

#endif // NETWORKMANAGER_H
