#include "wsthread.h"

WSThread::WSThread(qintptr sd, QObject *parent) : QThread(parent), socketDescriptor(sd)
{

}

void WSThread::run()
{
    tcpSocket = new QTcpSocket;

    qDebug() << "Thread started...";

    if (!tcpSocket->setSocketDescriptor(socketDescriptor))
    {
        qDebug() << tcpSocket->errorString();

        emit error(tcpSocket->error());
        return;
    }

    QByteArray block;
    QDataStream out(&block, QIODevice::WriteOnly);
    out.setVersion(QDataStream::Qt_4_0);
    out << QString("Dupa");
  //  out << WUManager::instance()->GetCurrentWeather();
 //   out << WUManager::instance()->GetLocation();
    tcpSocket->write(block);
    connect(tcpSocket, SIGNAL(disconnected()), this, SLOT(disconnected()));
    exec();
}

void WSThread::disconnected()
{
    qDebug() << tcpSocket->peerAddress() << " Disconnected";

    tcpSocket->deleteLater();
    exit(0);
}
