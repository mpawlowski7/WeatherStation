#include "wsthread.h"

WSThread::WSThread(qintptr sd, QObject *parent) : QThread(parent), socketDescriptor(sd)
{

}

WSThread::~WSThread()
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

//    qDebug() << tcpSocket->peerAddress().toString();

    connect(tcpSocket, SIGNAL(readyRead()), this, SLOT(readyRead()), Qt::DirectConnection);
    connect(tcpSocket, SIGNAL(disconnected()), this, SLOT(disconnected()));

    exec();
}

void WSThread::readyRead()
{
    QString ack = tcpSocket->readAll();

    qDebug() << ack;
    qDebug() << "Sending data...";

    QByteArray block;
    QDataStream out(&block, QIODevice::WriteOnly);
    out.setVersion(QDataStream::Qt_4_0);
 //   out << QString("Dupa");
    out << WUManager::instance()->GetCurrentWeather();
    out << WUManager::instance()->Get10DaysForecast();
    out << QString::number((LPS25H::instance()->GetTemperature() + HTS221::instance()->GetTemperature()) / 2, 'f', 1);
    out << QString::number(LPS25H::instance()->GetPressure(), 'f', 0);
    out << QString::number(HTS221::instance()->GetHumidity(), 'f', 0);
    tcpSocket->write(block);
    sleep(1);
}

void WSThread::disconnected()
{
    qDebug() << socketDescriptor << " Disconnected";

    tcpSocket->deleteLater();
    exit(0);
}
