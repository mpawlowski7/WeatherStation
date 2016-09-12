#include "wsthread.h"

WSThread::WSThread(int sd, QObject *parent) : QThread(parent), sd(sd)
{

}

void WSThread::run()
{
    QTcpSocket tcpSocket;

    if (!tcpSocket.setSocketDescriptor(sd))
    {
        emit error(tcpSocket.error());
        return;
    }

    QByteArray block;
    QDataStream out(&block, QIODevice::WriteOnly);
    out.setVersion(QDataStream::Qt_4_0);
    out << WUManager::instance()->Get10DaysForecast();
    out << WUManager::instance()->GetCurrentWeather();
    out << WUManager::instance()->GetLocation();
    tcpSocket.write(block);
    tcpSocket.disconnectFromHost();
    tcpSocket.waitForDisconnected();
}
