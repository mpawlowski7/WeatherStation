#ifndef NETWORKMANAGER_H
#define NETWORKMANAGER_H

#include <QTcpServer>
#include <QMutex>
#include <QThread>

class WSServer : public QTcpServer
{
    Q_OBJECT
    Q_DISABLE_COPY(WSServer)

private:
    static WSServer* volatile p_instance;
    WSServer(QObject* parent = 0) : QTcpServer(parent)
    {
    }
  //  WSServer(WSServer& rhs);
    ~WSServer();
    bool Init();
    bool Configure();

public:
    static WSServer* instance();
    void StartTransmission();
    void StopTransmission();

protected:
    void IncomingConnection(qintptr sd);

};

#endif // NETWORKMANAGER_H
